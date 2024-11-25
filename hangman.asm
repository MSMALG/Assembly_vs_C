.data
    .align 2                  # Align to word boundary (4 bytes)
word: .asciiz "CODE"           # Word to guess
guess: .byte 'G'              # Hardcoded guessed letter
correct: .word 0              # Initialize with a word (0 = incorrect)

.text
.globl main

main:
    la $t0, word              # Load address of the word
    lb $t1, guess             # Load the guessed letter
    li $t2, 0                 # Initialize correct flag to 0

check_letter:
    lb $t3, 0($t0)            # Load current letter from the word
    beq $t3, $zero, end_check # Exit loop if end of word 
    beq $t1, $t3, correct_guess # If guessed letter matches, set flag
    addi $t0, $t0, 1          # Move to the next letter
    j check_letter            # Repeat the loop

correct_guess:
    li $t2, 1                 # Set correct flag to 1

end_check:
    sw $t2, correct           # Store the result in memory
    j exit		      # End the program

exit:
    j exit                    # Infinite loop to stop execution
