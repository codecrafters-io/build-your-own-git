cmake_minimum_required(VERSION 3.13)

project(codecrafters-git)

file(GLOB_RECURSE SOURCE_FILES src/*.c src/*.h)

set(CMAKE_C_STANDARD 23) # Enable the C23 standard

find_package(OpenSSL REQUIRED)
find_package(ZLIB REQUIRED)

add_executable(git ${SOURCE_FILES})

target_link_libraries(git PRIVATE OpenSSL::Crypto)
target_link_libraries(git PRIVATE ZLIB::ZLIB)
