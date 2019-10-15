# valgrind_filter

This small bash script was made to select only issues that come from your program when running Valgrind.

It will run valgrind --leak-check=full --show-leak-kinds=all and will ignore issues that come from valgrind execution itself.

For this script to work properly, you have to use the -g3 flag while compiling your program with gcc.


Ex: gcc -g3 your_program.c

    sh valgrind_filter.sh a.out
    
    
Note that it is possible to add arguments to your program while using the script.
Launch the script without any argument for usage.
