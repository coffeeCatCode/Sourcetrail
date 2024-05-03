function(setGccTargetOptions targetName)
	target_compile_options(${targetName}
		PRIVATE
			-pipe

			-Wall
			-Wextra
			-Wpedantic

			#
			# Additional warnings:
			#
			-Wcast-align=strict
			-Wcast-qual
			-Wduplicated-branches
			-Wduplicated-cond
			-Wextra-semi
			# -Wfloat-equal
			# -Wformat=2
			# -Wformat-nonliteral
			-Wformat-overflow=2
			-Wformat-truncation=2
			-Wlogical-op
			-Wnon-virtual-dtor
			# -Wold-style-cast
			# -Woverloaded-virtual
			-Wsuggest-override
			# -Wundef
			-Wuninitialized
			# -Wunused-macros
			# -Wuseless-cast
			-Wwrite-strings

			#
			# Warnings which should be errors:
			#
			-Werror=suggest-override

			# Get the same behaviour then msvc for 'narrowing conversions'
			# See https://gcc.gnu.org/wiki/FAQ#Wnarrowing for further information.
			-Werror=narrowing

			#
			# Disabled warnings:
			#
			-Wno-comment
			-Wno-implicit-fallthrough
			-Wno-missing-field-initializers
			-Wno-sign-compare
			-Wno-stringop-truncation
			-Wno-unknown-pragmas
			-Wno-unused-parameter
			-Wno-unused-variable
		)

		target_compile_definitions(${targetName}
			PRIVATE
				$<$<CONFIG:Debug>:_FORTIFY_SOURCE=3>
				$<$<CONFIG:Debug>:_GLIBCXX_ASSERTIONS>

				# We would also like to enable these switches, but then we get linker errors with prebuild
				# libraries like boost, which have been build without them!
				# $<$<CONFIG:Debug>:_GLIBCXX_DEBUG>
				# $<$<CONFIG:Debug>:_GLIBCXX_DEBUG_PEDANTIC>
				# $<$<CONFIG:Debug>:_GLIBCXX_DEBUG_BACKTRACE>
		)
endfunction()

function(setMsvcTargetOptions targetName)
	target_compile_options(${targetName}
		PRIVATE
			/nologo
			/MP

			/permissive-
			/W4

			#
			# Additional warnings:
			#
			/w44265 # class has virtual functions, but destructor is not virtual

			#
			# Warnings which should be errors:
			#
			/we4172 # returning address of local variable or temporary
			/we4840 # non-portable use of class as an argument to a variadic function

			#
			# Disabled warnings:
			#
			/wd4100 # unreferenced formal parameter
			/wd4245 # signed/unsigned mismatch
			/wd4250 # inherits via dominance
			/wd4389 # '==': signed/unsigned mismatch
			/wd4456 # declaration hides previous local declaration
			/wd4457 # declaration hides function parameter
			/wd4458 # declaration hides class member
	)
	target_compile_definitions(${targetName}
		PUBLIC
			WIN32_LEAN_AND_MEAN

			# Target Windows 10:
			WINVER=0x0A00
			_WIN32_WINNT=0x0A00

	)
	target_link_options(${targetName}
		PUBLIC
			/NOLOGO
			# The output from the switches bellow are not visible in the output window :-(
			# /verbose:incr
			# /TIME
	)
endfunction()

function(setDefaultTargetOptions targetName)
	if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
		setGccTargetOptions(${targetName})
	elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
		setMsvcTargetOptions(${targetName})
	endif()
endfunction()
