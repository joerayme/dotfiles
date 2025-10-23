# Writing code

- We prefer simple, clean, maintainable solutions over clever or complex ones, even if the latter are more concise or performant. Readability and maintainability are primary concerns.
- We prefer explaining variables and small well-named methods over explanatory comments.
- Comments should only be used to explain why something is done if it is not clear from the code. Remove any superfluous comments.
- Make the smallest reasonable changes to get to the desired outcome. You MUST ask permission before reimplementing features or systems from scratch instead of updating the existing implementation.
- When modifying code, match the style and formatting of surrounding code, even if it differs from standard style guides. Consistency within a file is more important than strict adherence to external standards.
- When you are trying to fix a bug or compilation error or any other issue, YOU MUST NEVER throw away the old implementation and rewrite without explicit permission from the user. If you are going to do this, YOU MUST STOP and get explicit permission from the user.
- NEVER name things as 'improved' or 'new' or 'enhanced', etc. Code naming should be evergreen. What is new today will be "old" someday.
- NEVER log PII (Personally Identifiable Information) such as emails, names, phone numbers, addresses, etc. Always redact PII in log messages.

# Testing

- Tests MUST cover the functionality being implemented.
- NEVER ignore the output of the system or the tests - Logs and messages often contain CRITICAL information.
- TEST OUTPUT MUST BE PRISTINE TO PASS
- NO EXCEPTIONS POLICY: Under no circumstances should you mark any test type as "not applicable". Every project, regardless of size or complexity, MUST have unit tests, integration tests, AND end-to-end tests. If you believe a test type doesn't apply, you need the human to say exactly "I AUTHORIZE YOU TO SKIP WRITING TESTS THIS TIME"

## We practice TDD. That means:

- You MUST write tests before writing the implementation code
- You MUST run the tests to check that they fail
- You MUST only write enough code to make the failing test pass
- Refactor code continuously while ensuring tests still pass

The above is NOT NEGOTIABLE. You MUST follow TDD.

### TDD Implementation Process

- Write a failing test that defines a desired function or improvement
- Run the test to confirm it fails as expected
- Write minimal code to make the test pass
- Run the test to confirm success
- Refactor code to improve design while keeping tests green
- Repeat the cycle for each new feature or bugfix

If the test is for a new method, implement a stub of the method along with the tests before you check for a failing test.

### Critical TDD Requirements

- **ALWAYS verify test failure**: Every test must be run and confirmed to fail in the expected way before writing implementation code. This ensures the test is actually testing what you think it is.
- **Never skip the red phase**: If a test passes on the first run, it's likely not testing the right thing or there's already implementation code present.
- **One failing test at a time**: Focus on making one test pass before moving to the next. This keeps changes minimal and focused.
- **Test the behavior, not the implementation**: Tests should verify the expected output/behavior, not internal implementation details.
- **Update tests for new requirements**: When changing existing functionality, first update the tests to reflect the new expected behavior, confirm they fail, then update the implementation.
- **Tests never fail because of missing implementation**: If there is e.g. a missing function/method then that should be stubbed to check the expected behaviour is failing the test, not the lack of implementation or incorrect types

# Committing

Commit messages are in the format:

    Short description [<ticket number>]

    Longer description describing why the change has been made
    and calling out any decisions

    Co-authored-by: <any co-authors>

If being asked to commit code you should ensure the ticket number is provided, unless told to omit the ticket number.

# Tools

## Git

When using `git diff`, be sure to explicitly specify you want to use `diff` as the tool, since by default it uses a different, user-friendly output tool.

## Python

When writing one-off scripts, prefer using uv with inline dependencies and run the scripts with `uv run`