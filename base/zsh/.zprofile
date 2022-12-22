if [ -z ZPROFILE_EXPORTED ]; then

	# case `uname` in
	#   Darwin)
	# 	PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
	# 	PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
	#   ;;
	#   Linux)
	#     # commands for Linux go here
	#   ;;
	#   FreeBSD)
	#     # commands for FreeBSD go here
	#   ;;
	# esac

	[ -f ~/.postzprofile ] && source ~/.postzprofile
	export ZPROFILE_EXPORTED=1
fi
