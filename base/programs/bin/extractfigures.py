#!/usr/bin/env python3
import re
import argparse
import os
import shutil


def find_linked_files(latex_file_path, base_dir):
    """
    Finds all files linked in a LaTeX document (\includegraphics, \input, \include).

    Args:
        latex_file_path (str): The path to the .tex file to scan.
        base_dir (str): The directory of the LaTeX file, for resolving relative paths.

    Returns:
        tuple: A tuple containing two sets:
               - A set of tuples for figures: {(relative_path, base_dir)}
               - A set of full paths for included .tex files to be scanned next.
    """
    # Regex for \includegraphics{...}
    figure_regex = r"\\includegraphics(?:\[.*?\])?\{(.*?)\}"
    # Regex for \input{...} or \include{...}
    include_regex = r"\\(?:input|include)\{(.*?)\}"

    found_figures = set()
    files_to_scan_next = set()

    try:
        with open(latex_file_path, "r", encoding="utf-8") as f:
            content = f.read()

            # Find all figures
            for fig_path in re.findall(figure_regex, content):
                found_figures.add((fig_path, base_dir))

            # Find all included .tex files
            for include_path in re.findall(include_regex, content):
                # Add .tex extension if not present
                if not include_path.endswith(".tex"):
                    include_path += ".tex"

                # Add the included .tex file itself to the list of assets to copy
                found_figures.add((include_path, base_dir))

                # Add the full path to the list of files to be scanned
                full_include_path = os.path.join(base_dir, include_path)
                files_to_scan_next.add(os.path.abspath(full_include_path))

            return found_figures, files_to_scan_next

    except FileNotFoundError:
        # This can happen if an included file is not found, which is a valid case.
        print(f"Info: Could not find file to scan: '{latex_file_path}'")
        return set(), set()
    except Exception as e:
        print(f"An error occurred while reading the file '{latex_file_path}': {e}")
        return set(), set()


def copy_assets(asset_data, dest_base_dir):
    """
    Copies the found asset files to a new directory, preserving structure.

    Args:
        asset_data (set): A set of tuples, where each tuple is
                           (relative_path, source_base_dir).
        dest_base_dir (str): The absolute path to the destination directory.
    """
    print(f"\n📂 Copying {len(asset_data)} files to: {dest_base_dir}")
    os.makedirs(dest_base_dir, exist_ok=True)

    copied_count = 0
    for path, source_base_dir in asset_data:
        source_path = os.path.join(source_base_dir, path)
        dest_path = os.path.join(dest_base_dir, path)

        if os.path.exists(source_path):
            try:
                dest_dir = os.path.dirname(dest_path)
                if dest_dir:
                    os.makedirs(dest_dir, exist_ok=True)

                shutil.copy2(source_path, dest_path)
                print(f"  -> Copied {path}")
                copied_count += 1
            except Exception as e:
                print(f"  -- Error copying {path}: {e}")
        else:
            print(f"  -- Skipped {path} (Source file not found)")

    print(f"\n✨ Successfully copied {copied_count} file(s).")


def main():
    """
    Main function to parse command-line arguments and run the extraction.
    """
    parser = argparse.ArgumentParser(
        description="Recursively extract and optionally copy all assets (figures, includes) from LaTeX documents."
    )
    parser.add_argument(
        "latex_files",
        nargs="+",  # Allows one or more arguments
        help="One or more paths to the root input LaTeX files.",
    )
    parser.add_argument(
        "--copyto",
        help="Optional path to a directory where all found assets will be copied.",
    )
    args = parser.parse_args()

    # --- Recursive search setup ---
    files_to_scan = [os.path.abspath(f) for f in args.latex_files]
    scanned_files = set()
    all_assets = set()  # Stores (relative_path, source_directory) tuples

    print("--- Starting recursive search ---")
    while files_to_scan:
        current_file = files_to_scan.pop(0)
        if current_file in scanned_files:
            continue

        print(f"🔍 Scanning: {current_file}")
        scanned_files.add(current_file)

        base_dir = os.path.dirname(current_file)
        figures, includes = find_linked_files(current_file, base_dir)

        all_assets.update(figures)

        # Add newly found .tex files to the scan queue
        for include_file in includes:
            if include_file not in scanned_files:
                files_to_scan.append(include_file)
    print("--- Search complete ---\n")

    if all_assets:
        print("✅ Found the following unique assets across all documents:")
        # Sort the results for consistent output
        sorted_assets = sorted(list(all_assets))

        for i, (path, source_dir) in enumerate(sorted_assets):
            full_path = os.path.join(source_dir, path)
            status = "✓ (Exists)" if os.path.exists(full_path) else "✗ (Not Found)"
            print(f"  {i + 1: >2}. {path:<40} - {status}")

        if args.copyto:
            copy_assets(sorted_assets, args.copyto)

    else:
        print("\n🤷 No assets were found in the provided document(s).")


if __name__ == "__main__":
    main()
