#!/bin/bash 

# Color set 
FG_DEFAULT="\\e[0;39m"

FG_RED="\\e[1;31m"
FG_GREEN="\\e[1;32m"
FG_YELLOW="\\e[1;33m"

color_print() 
{
	local output=
	while [ $# -ne 0 ]
	do
		case $1 in
			-r|--red)
				output=$FG_RED	
				;;

			-g|--green)
				output=$FG_GREEN
				;;

			-y|--yellow)
				output=$FG_YELLOW
				;;

			-d|--default)
				output=$FG_DEFAULT
				;;

			*)
				output="$1 "
				;;
		esac 

		echo -en "$output"
		output=
		shift 
	done

	echo -e "$FG_DEFAULT"
}

success() 
{
	color_print -g $*
}

fail() 
{
	color_print -r $*
}

warn() 
{
	color_print -y $*
}

info() 
{
	echo $*
}

# test function 
test() 
{
	success We   did it 
	fail "Oops, something go wrong !"
	warn "Notice: are you sure do this ?"
	info "In process ..."

	color_print \
		-d "defualt color" \
		-r "red color" \
		-g "green color" \
		-y "yellow color" 

	echo "color should be normal now!"
}

## run test ##
# test 
