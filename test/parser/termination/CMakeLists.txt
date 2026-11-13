# SPDX-License-Identifier: GPL-3.0-only
##
# @file CMakeLists.txt
#
# @copyright Copyright (C) 2013-2024 srcML, LLC. (www.srcML.org)
#
# Inputs that made the parser or lexer loop for ever. Each test only needs
# srcML to finish and to give back the input text, so it does not fix the
# markup of code that is not valid.

foreach(CASE IN ITEMS template_after_macro)
    add_test(NAME parser_terminates_${CASE}
             COMMAND ${CMAKE_COMMAND}
                 -DSRCML_EXE=${SRCML_EXE}
                 -DINPUT=${CMAKE_CURRENT_SOURCE_DIR}/${CASE}.cpp
                 -DWORK=${CMAKE_CURRENT_BINARY_DIR}/${CASE}
                 -P ${CMAKE_CURRENT_SOURCE_DIR}/terminates.cmake)
    set_tests_properties(parser_terminates_${CASE} PROPERTIES TIMEOUT 120)
endforeach()
