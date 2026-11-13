# SPDX-License-Identifier: GPL-3.0-only
##
# @file terminates.cmake
#
# @copyright Copyright (C) 2013-2024 srcML, LLC. (www.srcML.org)
#
# Run srcML on INPUT with a time limit, then turn the srcML back into text.
# The test passes when both runs end and the text is the same as INPUT.

file(MAKE_DIRECTORY ${WORK})

execute_process(COMMAND ${SRCML_EXE} --language=C++ ${INPUT} -o ${WORK}/out.xml
                TIMEOUT 60 RESULT_VARIABLE RESULT)
if(NOT RESULT EQUAL 0)
    message(FATAL_ERROR "srcML did not finish on ${INPUT}: ${RESULT}")
endif()

execute_process(COMMAND ${SRCML_EXE} ${WORK}/out.xml -o ${WORK}/out.cpp
                TIMEOUT 60 RESULT_VARIABLE RESULT)
if(NOT RESULT EQUAL 0)
    message(FATAL_ERROR "srcML could not read its own output for ${INPUT}: ${RESULT}")
endif()

execute_process(COMMAND ${CMAKE_COMMAND} -E compare_files ${INPUT} ${WORK}/out.cpp
                RESULT_VARIABLE RESULT)
if(NOT RESULT EQUAL 0)
    message(FATAL_ERROR "the text of ${INPUT} changed in the round trip")
endif()
