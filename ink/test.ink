# CHOICE_NUMBERS: off
# AUTO_CLEAR: on

VAR code = ""
VAR retry_count = 0

=== test ===

-> start
= start

Some long long long story... Some long long long story... Some long long long story... Some long long long story...
Some long long long story... Some long long long story... Some long long long story... Some long long long story...
Some long long long story... Some long long long story... Some long long long story... Some long long long story...
Some long long long story... Some long long long story... Some long long long story... Some long long long story...
Some long long long story... Some long long long story... Some long long long story... Some long long long story...

You have {2 - retry_count} attempts!

— Ready?

# USER_INPUT: code "Enter the code"

-> check_code
= check_code

~ retry_count += 1

{ code == "12345":
    -> correct_code
- else:
    -> incorrect_code
}

= correct_code

# CLEAR

You entered correct code: {code}. Count of retries: {retry_count}. Congratulations!

-> END

= incorrect_code

Entered INCORRECT code: {code}. Count of retries: {retry_count}

+ [try again] -> start
