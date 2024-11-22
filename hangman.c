#include <stdio.h>
#include <string.h>
#define WORD "CODE"
#define MAX_TRIES 5

int main() {
    int tries = MAX_TRIES, correct_guesses = 0;
    char guess;

    while (tries > 0 && correct_guesses < strlen(WORD)) {
        printf("Guess a letter: ");
        scanf(" %c", &guess);

        if (strchr(WORD, guess)) {  // Check if guess is in WORD
            printf("\nCorrect!\n");
            correct_guesses++;
        } else {
            tries--;
            printf("\nIncorrect! Tries left: %d\n", tries);
        }
    }

    if (correct_guesses == strlen(WORD))
        printf("\nYou won!\nThe word was: %s\n", WORD);
    else
        printf("\nYou lost! The word was: %s\n", WORD);

    return 0;
}
