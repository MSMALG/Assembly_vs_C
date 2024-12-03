#include <stdio.h>
#include <string.h>

int main() {
    char word[] = "CODE"; // Word to guess
    char guess = 'F';     // Hardcoded guessed letter
    int correct = 0;      // Correct flag (0 = incorrect)

    for (int i = 0; i < strlen(word); i++) {
        if (word[i] == guess) {
            correct = 1;
            break;
        }
    }

    printf("Correct: %d\n", correct); // Output the result
    return 0;
}