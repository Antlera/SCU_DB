# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.20

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /snap/clion/169/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /snap/clion/169/bin/cmake/linux/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/cmake-build-debug

# Include any dependencies generated for this target.
include test/CMakeFiles/b_plus_tree_concurrent_test.dir/depend.make
# Include the progress variables for this target.
include test/CMakeFiles/b_plus_tree_concurrent_test.dir/progress.make

# Include the compile flags for this target's objects.
include test/CMakeFiles/b_plus_tree_concurrent_test.dir/flags.make

test/CMakeFiles/b_plus_tree_concurrent_test.dir/index/b_plus_tree_concurrent_test.cpp.o: test/CMakeFiles/b_plus_tree_concurrent_test.dir/flags.make
test/CMakeFiles/b_plus_tree_concurrent_test.dir/index/b_plus_tree_concurrent_test.cpp.o: ../test/index/b_plus_tree_concurrent_test.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object test/CMakeFiles/b_plus_tree_concurrent_test.dir/index/b_plus_tree_concurrent_test.cpp.o"
	cd /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/cmake-build-debug/test && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/b_plus_tree_concurrent_test.dir/index/b_plus_tree_concurrent_test.cpp.o -c /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/test/index/b_plus_tree_concurrent_test.cpp

test/CMakeFiles/b_plus_tree_concurrent_test.dir/index/b_plus_tree_concurrent_test.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/b_plus_tree_concurrent_test.dir/index/b_plus_tree_concurrent_test.cpp.i"
	cd /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/cmake-build-debug/test && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/test/index/b_plus_tree_concurrent_test.cpp > CMakeFiles/b_plus_tree_concurrent_test.dir/index/b_plus_tree_concurrent_test.cpp.i

test/CMakeFiles/b_plus_tree_concurrent_test.dir/index/b_plus_tree_concurrent_test.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/b_plus_tree_concurrent_test.dir/index/b_plus_tree_concurrent_test.cpp.s"
	cd /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/cmake-build-debug/test && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/test/index/b_plus_tree_concurrent_test.cpp -o CMakeFiles/b_plus_tree_concurrent_test.dir/index/b_plus_tree_concurrent_test.cpp.s

# Object files for target b_plus_tree_concurrent_test
b_plus_tree_concurrent_test_OBJECTS = \
"CMakeFiles/b_plus_tree_concurrent_test.dir/index/b_plus_tree_concurrent_test.cpp.o"

# External object files for target b_plus_tree_concurrent_test
b_plus_tree_concurrent_test_EXTERNAL_OBJECTS =

test/b_plus_tree_concurrent_test: test/CMakeFiles/b_plus_tree_concurrent_test.dir/index/b_plus_tree_concurrent_test.cpp.o
test/b_plus_tree_concurrent_test: test/CMakeFiles/b_plus_tree_concurrent_test.dir/build.make
test/b_plus_tree_concurrent_test: lib/libvtable.so
test/b_plus_tree_concurrent_test: lib/libsqlite3.so
test/b_plus_tree_concurrent_test: lib/libgtest.so
test/b_plus_tree_concurrent_test: test/CMakeFiles/b_plus_tree_concurrent_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable b_plus_tree_concurrent_test"
	cd /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/cmake-build-debug/test && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/b_plus_tree_concurrent_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
test/CMakeFiles/b_plus_tree_concurrent_test.dir/build: test/b_plus_tree_concurrent_test
.PHONY : test/CMakeFiles/b_plus_tree_concurrent_test.dir/build

test/CMakeFiles/b_plus_tree_concurrent_test.dir/clean:
	cd /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/cmake-build-debug/test && $(CMAKE_COMMAND) -P CMakeFiles/b_plus_tree_concurrent_test.dir/cmake_clean.cmake
.PHONY : test/CMakeFiles/b_plus_tree_concurrent_test.dir/clean

test/CMakeFiles/b_plus_tree_concurrent_test.dir/depend:
	cd /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/test /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/cmake-build-debug /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/cmake-build-debug/test /home/yneversky/ynwork/SCUDB_LAB/LAB2-DONE/cmake-build-debug/test/CMakeFiles/b_plus_tree_concurrent_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : test/CMakeFiles/b_plus_tree_concurrent_test.dir/depend

