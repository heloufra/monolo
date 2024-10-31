#include <stdio.h>
#include <unistd.h>
#include <string.h>

#define MAX_ROWS 10

void generateTriangle(long triangle[MAX_ROWS + 1][MAX_ROWS + 1]) {
    int row, col;
    
    // Initialize first element
    triangle[0][0] = 1;
    
    // Generate subsequent rows
    for (row = 1; row <= MAX_ROWS; row++) {
        // First number of each row is 1
        triangle[row][0] = 1;
        
        // Calculate middle values
        for (col = 1; col <= row; col++) {
            triangle[row][col] = triangle[row-1][col-1] + triangle[row-1][col];
        }
    }
}

void printTriangle(long triangle[MAX_ROWS + 1][MAX_ROWS + 1]) {
    int row, col, space;
    
    printf("Pascal's Triangle:\n\n");
    
    for (row = 0; row <= MAX_ROWS; row++) {
        // Print leading spaces for alignment
        for (space = 0; space < (MAX_ROWS - row) * 3; space++) {
            printf(" ");
        }
        
        // Print numbers in current row
        for (col = 0; col <= row; col++) {
            printf("%6ld", triangle[row][col]);
        }
        printf("\n");
    }|||
}

int main()
{
    int matrix[10][10];

      long triangle[MAX_ROWS + 1][MAX_ROWS + 1] = {0};  // Initialize array with zeros
    
    generateTriangle(triangle);
    printTriangle(triangle);
    return 0;
}

int atoi(char *str)
{
    int len = strlen(str) - 1;
    int i = 0;
    int nbr = 0;

    if (str[0] == '-')
        i++;

    while (i < len)
    {
        if (str[i] < '0' || str[i] > '9')
            break;
        nbr = 10 * nbr + str[i] - '0';
        i++;
    }

    if (str[0] == '-')
        return nbr * -1;
    return nbr;
}