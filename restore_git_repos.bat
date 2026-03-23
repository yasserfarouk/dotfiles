
REM Repository: personal/dotfiles
echo Restoring: personal/dotfiles
if exist "personal\dotfiles\.git" (
    echo   Directory already exists, skipping...
) else (
    REM Create parent directory if needed
    if not exist "personal" mkdir "personal"
    
    REM Clone the repository
    git clone "git@github.com:yasserfarouk/dotfiles.git" "personal\dotfiles"
    if errorlevel 1 (
        echo   Failed to clone
    ) else (
        echo   Successfully cloned
        
        REM Checkout the original branch if not already on it
        cd "personal\dotfiles"
        git checkout "master" 2>nul
        if errorlevel 1 (
            echo   Could not checkout branch: master
        ) else (
            echo   Checked out branch: master
        )
        cd ..\..
    )
)
echo.


REM Repository: personal/dotfiles
echo Restoring: personal/dotfiles
if exist "personal\dotfiles\.git" (
    echo   Directory already exists, skipping...
) else (
    REM Create parent directory if needed
    if not exist "personal" mkdir "personal"
    
    REM Clone the repository
    git clone "git@github.com:yasserfarouk/dotfiles.git" "personal\dotfiles"
    if errorlevel 1 (
        echo   Failed to clone
    ) else (
        echo   Successfully cloned
        
        REM Checkout the original branch if not already on it
        cd "personal\dotfiles"
        git checkout "master" 2>nul
        if errorlevel 1 (
            echo   Could not checkout branch: master
        ) else (
            echo   Checked out branch: master
        )
        cd ..\..
    )
)
echo.

