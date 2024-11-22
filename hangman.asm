.data
word: .asciiz "CODE"               # Word to guess
prompt: .asciiz "\nGuess a letter: "
correct_text: .asciiz "\nCorrect!\n"
incorrect_text: .asciiz "\nIncorrect! Tries left: "
win_text: .asciiz "\nYou won!\nThe word was: CODE\n"
lose_text: .asciiz "\nYou lost! The word was: CODE\n"
tries_left: .word 5                # Initialize tries left in memory
correct_guesses: .word 0           # Initialize correct guesses in memory

.text
.globl main

main:
    lw $t0, tries_left             # Load tries left from memory
    lw $t1, correct_guesses        # Load correct guesses from memory

game_loop:
    lui $t3, 0                     # Set word length (upper half)
    ori $t3, $t3, 4                # Word length is 4
    beq $t1, $t3, win_game         # Win if correct guesses = word length
    beqz $t0, lose_game            # Lose if no tries left

    # Prompt for letter guess
    li $v0, 4
    la $a0, prompt
    syscall
    li $v0, 12                     # Read char
    syscall
    move $t4, $v0                  # Guessed letter

    # Check guess against each letter in word
    la $t2, word
    li $t6, 0                      # Correct flag

check_letter:
    lb $t7, 0($t2)                 # Load letter from word
    beqz $t7, incorrect_guess      # If end of word, guess was incorrect
    beq $t4, $t7, correct_guess    # Correct guess if match
    addi $t2, $t2, 1
    j check_letter

correct_guess:
    addi $t1, $t1, 1               # Increment correct guesses
    sw $t1, correct_guesses        # Update correct guesses in memory
    li $t6, 1                      # Set correct flag
    li $v0, 4
    la $a0, correct_text
    syscall
    j game_loop

incorrect_guess:
    beq $t6, 1, game_loop          # Skip decrement if correct flag set
    addi $t0, $t0, -1              # Decrement tries left
    sw $t0, tries_left             # Update tries left in memory
    li $v0, 4
    la $a0, incorrect_text
    syscall
    li $v0, 1
    move $a0, $t0
    syscall
    j game_loop

win_game:
    li $v0, 4
    la $a0, win_text
    syscall
    j exit

lose_game:
    li $v0, 4
    la $a0, lose_text
    syscall

exit:
    li $v0, 10                     # Exit
    syscall
