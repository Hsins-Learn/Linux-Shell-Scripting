# Section 03: User and Account Creation

- [Section 03: User and Account Creation](#section-03-user-and-account-creation)
  - [Naming, Permissions, Variables, Builtins](#naming-permissions-variables-builtins)
    - [Shebang](#shebang)
    - [Permissions](#permissions)
    - [Built-In Commands (builtin)](#built-in-commands-builtin)
    - [Variables](#variables)
  - [Special Variables, Pseudocode, Command Substitution, Conditions](#special-variables-pseudocode-command-substitution-conditions)
    - [`UID` and `EUID`](#uid-and-euid)
    - [If Statements](#if-statements)
  - [Exit Statuses, Return Codes, String Test Conditionals](#exit-statuses-return-codes-string-test-conditionals)
    - [Exit Values](#exit-values)
    - [Special Variables](#special-variables)
  - [Reading Standard Input, Creating Accounts, Username Convention](#reading-standard-input-creating-accounts-username-convention)
    - [`read` Command](#read-command)
    - [`useradd` Command](#useradd-command)
    - [`passwd` Command](#passwd-command)
  - [[Project 01] Add Local User](#project-01-add-local-user)
    - [Goal and Scenario](#goal-and-scenario)
    - [Shell Script Requirements](#shell-script-requirements)
    - [Solution](#solution)

## Naming, Permissions, Variables, Builtins

```bash
#!/bin/bash

# ============================================================
# The main goals of this scripts are:
#   - Displays various informaiton to the screen.
#   - Show how to use variables with `echo` command.
# ============================================================

# Display 'Hello'
echo 'Hello'

# Assign a value to a variable
WORD='script'

# Display that value using the variable
echo "$WORD"

# Demonstrate that single quotes cause variables to NOT get expanded.
echo '$WORD'

# Combine the variable with hard-coded text.
echo "This is a shell $WORD"

# Display the contents of the variable using an alternative syntax.
echo "This is a shell ${WORD}"

# Append text to the variable.
echo "${WORD}ing is fun!"

# Show how NOT to append text to a variable
# This doesn't work:
echo "$WORDing is fun!"

# Create a new variable
ENDING='ed'

# Combine the two variables
echo "This is ${WORD}${ENDING}"

# Change the value stored in the ENDING variable (Reassignment)
ENDING='ing'
echo "This is ${WORD}${ENDING}"

# Reassign value to ENDING
ENDING='s'
echo "You are going to write many ${WORD}${ENDING} in this class!"
```

- The shell scripts files can end in `.sh` by convention, but the file extension is not significant.
- The dot symbol `.` in `./luser-demo01.sh` represents the current directory and dot-dot symbol `..` represents the parent directory.

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### Shebang

In the first line, there's a hash symbol `#` followed an exclamation point and then a path. The line is call a `shebang`.

```bash
#!/bin/bash
```

- The code inside the script will be interpreted by the command defined with the **shebang**.
- If we don't supply a **shabang** and specify an interpreter on the first line of the script, the code inside the script will be executed using the current shell.

By the way, the other lines started with a hash symbol `#` but not followed an exclamation point are comments. They're just simply there for humans only and will not be executed.

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### Permissions

We can use the command `ls -l` to list one file per line in folder and check its permission. Each start line with 9 characters to represents the permissons of the owner, group and everyone else.

```bash
$ ls -l
  -rw-r--r-- 1 vagrant vagrant 15 Oct 27 05:44 luser-demo01.sh

#  rw-       : ↑ User vagrant has read/write permissions
#     r--    :         ↑ Group vagrant has read permissions
#        r-- :           Everyone else has read permissions
```

If we want to add execute permissions so that anyone else can actually execute the file, we need to use `chmod` command:

```bash
$ chmod 755 luser-demo01.sh
$ ls -l
  -rwxr-xr-x 1 vagrant vagrant 15 Oct 27 05:44 luser-demo01.sh
```

Let's see what the number `755` means in the command. Each number in `755` is the sum of `4 (read)`, `2 (write)` and `1 (execute)` permission:

- `7 = 4 + 2 + 1` means `rwx`
- `5 = 4 + 0 + 1` means `r-x`
- `5 = 4 + 0 + 1` means `r-x`

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### Built-In Commands (builtin)

The `echo` is a command that's built within the shell and doesn't require any external programs to execute. We can use `type` command to show the path and if it's a shell built-in execution.

```bash
$ type echo
  echo is a shell builtin
$ type -a echo
  echo is a shell builtin
  echo is /usr/bin/echo
```

If we want to get help on a shell built-in, we can use `help` command to show the instructions.

```bash
$ help echo
  echo: echo [-neE] [arg ...]
      Write arguments to the standard output.

      Display the ARGs on the standard output followed by a newline.

      Options:
        -n        do not append a newline
        -e        enable interpretation of the following backslash escapes
        -E        explicitly suppress interpretation of backslash escapes

      `echo' interprets the following backslash-escaped characters:
        \a        alert (bell)
        \b        backspace
        \c        suppress further output
        \e        escape character
        \f        form feed
        \n        new line
        \r        carriage return
        \t        horizontal tab
        \v        vertical tab
        \\        backslash
        \0nnn     the character whose ASCII code is NNN (octal).  NNN can be
                  0 to 3 octal digits
        \xHH      the eight-bit character whose value is HH (hexadecimal).  HH
                  can be one or two hex digits

      Exit Status:
      Returns success unless a write error occurs.
```

The `uptime` is not a shell built-in command. So if we run `help uptime`, we're not gonna get anything. However we can use `man` command instead.

```bash
$ man uptime
```

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### Variables

We can assign a value to a variable by using the syntax shown below.

```bash
# assign variables
WORD='script'

# using variables
echo "$WORD"
echo '$WORD'
echo "This is a shell $WORD"
echo "This is a shell ${WORD}"

# using variables
echo "This is a shell $WORD"
# Display the contents of the variable using an alternative syntax.
echo "This is a shell ${WORD}"
```

- It's very important that **there is no space in between the `=` sign**.
- The string value should be enclosed in quotation marks either a single quotation marks or double quotation marks.
- Use a descriptive name for variables for easier reading.
- When use the variables, put a dollar sign `$` front. Note that whe `echo` will not expand variables enclosed in double quote marks.

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

## Special Variables, Pseudocode, Command Substitution, Conditions

```bash
#!/bin/bash

# ============================================================
# The main goals of this scripts are:
#   - Displays the UID and username of the user executing this
#     this script.
#   - Displays if the user is the root user or not
# ============================================================

# Display the UID
echo "Your UID is ${UID}"

# Display the username
# ' Note that there is an older syntax to assign the command result
# ' to a variable by using the tick marks:
# ' USER_NAME=`id -un`
USER_NAME=$(id -un)
echo "Your username is ${USER_NAME}"

# Display if the user is the root user or not
if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root.'
else
  echo 'You are not root.'
fi
```

- We use the `UID` to distinguish whether the user is root or not. Because the `UID` of `0` is always assigned to the root on every Linux system.
- Just try to run the script with `vagrant` user and `root` user. We can use command `sudo` or `su` to switch to the root user.

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### `UID` and `EUID`

There are so many variables set by the shell (We can find the `Shell Variables` in the manual). The `UID` and `EUID` both are the shell variables, let's see the explanation of `UID` and `EUID` in manual.

> - `UID`: Expands to the user ID of the current user, initialized at shell startup. This variable is readonly.
> - `EUID`: Expands to the effective user ID of the current user, initialized at shell startup. This variable is readonly.

In reality, we can use `UID` or `ID` to represent the current user because both of them are going to be the same if we're working on the modern Linux system. (The only time that the `UID` would be different from `EUID` is in the case of a script use `setid` to change.)

Moreover, we can use the command `id` or `whoami` to show the current user:

```bash
$ id
  uid=1000(vagrant) gid=1000(vagrant) groups=1000(vagrant)
$ id -u
  1000
$ id -un
$ id -u -n
  vagrant
$ whoami
  vagrant
```

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### If Statements

The `if` statements let us execute commands based on conditional.

```bash
# Display if the user is the root user or not
if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root.'
else
  echo 'You are not root.'
fi
```

- The script would executed the `if COMMANDS` list first. If its exit status is zero, then the `then COMMANDS` list would be executed. Otherwise, each `elif COMMANDS` list would be executed in turn.
- Those double brackets `[[` and `]]` are acutally a shell keyword. Note that `[[ exepression ]]` returns a status of `0` or `1` depending on the evaluation of the conditional expression.
- Expressions are composed of the same primaries used by the `test` builtin, so that we can use `test` command to generate our expressions.
- It's important to know that the double brackets syntax we're using with the if statement is a bash specific thing. It's may not be portable to all shells.
- There is an old way to use single bracekets to enclose the expression.

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

## Exit Statuses, Return Codes, String Test Conditionals

```bash
#!/bin/bash

# ============================================================
# The main goals of this scripts are:
#   - Displays the UID and username of the user executing this
#     this script.
#   - Displays if the user is the vagrant user or not
# ============================================================

# Display the UID
echo "Your UID is ${UID}"

# Only display if the UID does NOT match 1000
UID_TO_TEST_FOR='1000'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
  echo "Your UID does not match ${UID_TO_TEST_FOR}"
  exit 1
fi

# Display the username
USER_NAME=$(id -un)

# Test if the command succeeded.
if [[ "${?}" -ne 0 ]]; then
  echo "The id command did not execute succesfully."
  exit 1
fi
echo "Your user name is ${USER_NAME}"

# You can use a string test conditional.
USER_NAME_TO_TEST_FOR='vagrant'
if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST_FOR}" ]]
then
  echo "Your username matches ${USER_NAME_TO_TEST_FOR}."
fi

# Test for != (not equal) for the string.
if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST_FOR}" ]]
then
  echo "Your username does not match ${USER_NAME_TO_TEST_FOR}."
  exit 1
fi

exit 0
```

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### Exit Values

```bash
UID_TO_TEST_FOR='1000'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
  echo "Your UID does not match ${UID_TO_TEST_FOR}"
  exit 1
fi
```

The `exit` is a shell builtin. It exits the shell with the status by a number of `N`. The exit status are returns after each each command are being excuted, and we use `0` to represent success and other number for wrong in usual.

Moreover, we can use `man` to check the meanings of exit value. Take the `adduser` command for example, it exits with the following values:

- 0: success
- 1: can't update password file
- 2: invalid command syntax
- 3: invalid argument to option
- 4: UID already in use (and no -o)
- 6: specified group doesn't exist
- 9: username already in use
- 10: can't update group file
- 12: can't create home directory
- 14: can't update SELinux user mapping

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### Special Variables

The `${?}` is one of the special variables in bash. It holds the exit status of the most recently executed command. In the following example from the script `luser-demo03.sh`, the `${?}` hold the exit status of command `$(id -un)`.

```bash
# Display the username
USER_NAME=$(id -un)

# Test if the command succeeded.
if [[ "${?}" -ne 0 ]]; then
  echo "The id command did not execute succesfully."
  exit 1
fi
echo "Your user name is ${USER_NAME}"
```

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

## Reading Standard Input, Creating Accounts, Username Convention

```bash
#!/bin/bash

# ============================================================
# The main goals of this scripts are:
#   - Create an account on the local system
#   - Prompt user for the account name and password
# ============================================================

# Ask for the user name
read -p 'Enter the username to create: ' USER_NAME

# Ask for the real name
read -p 'Enter the name of the person who this account is for: ' COMMENT

# Ask for the password
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user
useradd -c "${COMMENT}" -m ${USER_NAME}

# Set the password for the user
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login
passwd -e ${USER_NAME}
```

- We put the `COMMENT` variable in double quotes because the `COMMENT` variable may contain spaces.

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### `read` Command

```bash
read -p 'Enter the username to create: ' USER_NAME
read -p 'Enter the name of the person who this account is for: ' COMMENT
read -p 'Enter the password to use for the account: ' PASSWORD

echo "${USER_NAME}"
```

We're going to use the `read` builtin to read a single line from the standard input.

- There are actually three default input/output.
  - **standard input**: input from the keyboard by default.
  - **standard output**: display on the screen.
  - **standard error**: display on the screen.
- The option `-p` will act the following string as a prompt.

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### `useradd` Command

We use `useradd` command to create a user account so that we can use `su` command to switch by users.

```bash
$ sudo useradd dougstamper
$ sudo su - dougstamper
```

- The `-` option to the `su` command tells us to start with an environment similar to that of a real log in. We can also use `su -L` to get the same experience.
- Username are case sensitive so user `johnlee` is not the same user as `JohnLee`. But the convention they're in all lowercase.

```bash
USER_NAME="john"
COMMENT="John Lee"
useradd -c "${COMMENT}" -m ${USER_NAME}
```

- The `-c` option can be any text string. It is generally a short description of the login, currently used as the field for the user's full name.
- The `-m` option would create the user's home directory if it doens't exist. (The files and the directories contained in the skeleton directory `skel` will be copied into the home directory.)
- By default, the `-m` option of `useradd` command is not specified and `CREATE_HOME` is not enable, no home directories are created. The configuration variables are stored in the `/etc/login.defs`.

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### `passwd` Command

By default, the `passwd` command will prompt you to enter a new password for the current user. We have to specify the user to change password for another user.

```bash
# Set the password for the user
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Force password change on first login
passwd -e ${USER_NAME}
```

- We use a pipe symbol `|` on a command line to take the standard output from the preceding command. The command goes before the pipe and pass it as the standard input to the following command.
- The `--stdin` option is used to indicate that `passwd` should read the new password from standard input, which can be a **pipe**.
- The `-e` option is quick way to expire a password from an account. The user will be forced to change the password during the next login attempt.

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

## [Project 01] Add Local User

### Goal and Scenario

The goal of this exercise is to create a shell script that adds users to the same Linux system as the script is executed on.

Imagine that you're working as a Linux System Administrator for a fast growing company. The latest company initiative requires you to build and deploy dozens of servers. You're falling behind schedule and are going to miss your deadline for these new server deployments because you are constantly being interrupted by the help desk calling you to create new Linux accounts for all the people in the company who have been recruited to test out the company's newest Linux-based application.

In order to meet your deadline and keep your sanity, you decide to write a shell script that will create new user accounts. Once you're done with the shell script you can put the help desk in charge of creating new accounts which will finally allow you to work uninterrupted and complete your server deployments on time.

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### Shell Script Requirements

- Is named `add-local-user.sh`.
- Enforces that it be executed with superuser (root) privileges. If the script is not executed with superuser privileges it will not attempt to create a user and returns an exit status of `1`.
- Prompts the person who executed the script to enter the username (login), the name for person who will be using the account, and the initial password for the account.
- Creates a new user on the local system with the input provided by the user.
- Informs the user if the account was not able to be created for some reason. If the account is not created, the script is to return an exit status of `1`.
- Displays the username, password, and host where the account was created. This way the help desk staff can copy the output of the script in order to easily deliver the information to the new account holder.

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### Solution

```bash
#!/bin/bash

# ============================================================
# This script creates a new user on the local system:
#   - You will be prompted to enter the username (login),
#     the person name and a password.
#   - The username, password and host for the account will
#     be displayed.
# ============================================================

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]; then
  echo 'Please run with sudo or as root.'
  exit 1
fi

# Get the username (login).
read -p 'Enter the username to create: ' USER_NAME

# Get the real name (contents for the description field).
read -p 'Enter the name of the person or application that will be using this account: ' COMMENT

# Get the password.
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the account.
useradd -c "${COMMENT}" -m ${USER_NAME}

# Check to see if the useradd command succeeded.
# We don't want to tell the user that an account was created when it hasn't been.
if [[ "${?}" -ne 0 ]]; then
  echo 'The account could not be created.'
  exit 1
fi

# Set the password
echo ${PASSWORD} | passwd --std ${USER_NAME}

if [[ "${?}" -ne 0 ]]; then
  echo 'The password for the account could not be set.'
fi

# Force password change on first login
passwd -e ${USER_NAME}

# Display the username, password and the host where the user was created.
echo
echo "username  : ${USER_NAME}"
echo "password  : ${PASSWORD}"
echo "host      : ${HOSTNAME}"

exit 0
```

<br/>
<div align="right">
  <b><a href="#section-03-user-and-account-creation">[ ↥ Back To Top ]</a></b>
</div>
<br/>