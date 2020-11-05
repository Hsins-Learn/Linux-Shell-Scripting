# Section 04: Password Generation and Shell Script Arguments

- [Section 04: Password Generation and Shell Script Arguments](#section-04-password-generation-and-shell-script-arguments)
  - [Random Data, Cryptographic Hash Functions, Text and String Manipulation](#random-data-cryptographic-hash-functions-text-and-string-manipulation)
    - [`RANDOM` Variable](#random-variable)
    - [`date` Command](#date-command)
    - [`checksum` Command](#checksum-command)
    - [`head` Command](#head-command)
    - [`shuf` Command](#shuf-command)
  - [Positional Parameters, Arguments, For Loops and Special Parameters](#positional-parameters-arguments-for-loops-and-special-parameters)
  - [The While Loop, Infinite Loop, Shifting and Sleeping](#the-while-loop-infinite-loop-shifting-and-sleeping)
  - [[Project 02] Random Password](#project-02-random-password)
    - [Goal and Scenario](#goal-and-scenario)
    - [Shell Script Requirements](#shell-script-requirements)
    - [Solution](#solution)

## Random Data, Cryptographic Hash Functions, Text and String Manipulation

```bash
#!/bin/bash

# ============================================================
# The main goals of this scripts are:
#   - Generates a list of random passwords
# ============================================================

# A random number as a password.
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

# Three random numbers together.
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

# Use the current date/time as the basis for the password.
PASSWORD=$(date +%s)
echo "${PASSWORD}"

# Use nanoseconds to act as randomization.
PASSWORD=$(date +%s%N)
echo "${PASSWORD}"

# A better password.
PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "${PASSWORD}"

# A even better password.
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
echo "${PASSWORD}"

# Append a special character to the password.
SPECIAL_CHARACTER=$(echo '!@#$%^&*()_-+=' | fold -w1 | shuf | head -c1)
echo "${PASSWORD}${SPECIAL_CHARACTER}"
```

- We can use the `RANDOM` variable and `date` command to generate the password.
- To be more secure, combine the `shuf` and `fold` command.

<br/>
<div align="right">
  <b><a href="#section-04-password-generation-and-shell-script-arguments">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### `RANDOM` Variable

<br/>
<div align="right">
  <b><a href="#section-04-password-generation-and-shell-script-arguments">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### `date` Command

<br/>
<div align="right">
  <b><a href="#section-04-password-generation-and-shell-script-arguments">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### `checksum` Command

```bash
$ ls -l /usr/bin/*sum
  -rwxr-xr-x. 1 root root 33136 Nov  5  2016 /usr/bin/cksum
  -rwxr-xr-x. 1 root root 41504 Nov  5  2016 /usr/bin/md5sum
  -rwxr-xr-x. 1 root root 37456 Nov  5  2016 /usr/bin/sha1sum
  -rwxr-xr-x. 1 root root 41600 Nov  5  2016 /usr/bin/sha224sum
  -rwxr-xr-x. 1 root root 41600 Nov  5  2016 /usr/bin/sha256sum
  -rwxr-xr-x. 1 root root 41592 Nov  5  2016 /usr/bin/sha384sum
  -rwxr-xr-x. 1 root root 41592 Nov  5  2016 /usr/bin/sha512sum
  -rwxr-xr-x. 1 root root 37432 Nov  5  2016 /usr/bin/sum
```

<br/>
<div align="right">
  <b><a href="#section-04-password-generation-and-shell-script-arguments">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### `head` Command

```bash
$ head -n1 /etc/passwd
$ head -n 1 /etc/passwd
$ head -1 /etc/passwd
$ head -2 /etc/passwd
$ head -n2 /etc/passwd
$ head -n 2 /etc/passwd
$ head -c1 /etc/passwd
$ head -c2 /etc/passwd
```

<br/>
<div align="right">
  <b><a href="#section-04-password-generation-and-shell-script-arguments">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### `shuf` Command

<br/>
<div align="right">
  <b><a href="#section-04-password-generation-and-shell-script-arguments">[ ↥ Back To Top ]</a></b>
</div>
<br/>

## Positional Parameters, Arguments, For Loops and Special Parameters

```bash
#!/bin/bash

# ============================================================
# The main goals of this scripts are:
#   - Generates a random password for each user specified on
#     the command line.
# ============================================================

# Display what the user typed on the command line
echo "You executed this command: ${0}"

# Display the path and the filename of the script
echo "You used $(dirname ${0}) as the path to the $(basename ${0}) script."

# Tell them how many arguments they passed in.
# (Inside the script they are parameters, outside they are arguments.)
NUMBER_OF_PARAMETERS="${#}"
echo "You supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line."

# Make sure they at least supply one argument.
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]; then
  echo "Usage: ${0} USER_NAME [USER_NAME]..."
  exit 1
fi

# Generate and display a password for each parameter.
for USER_NAME in "${*}"; do
  PASSWORD=$(date +%s%N | sha256sum | head -c48)
  echo "${USER_NAME}: ${PASSWORD}"
done
```

<br/>
<div align="right">
  <b><a href="#section-04-password-generation-and-shell-script-arguments">[ ↥ Back To Top ]</a></b>
</div>
<br/>

## The While Loop, Infinite Loop, Shifting and Sleeping

<br/>
<div align="right">
  <b><a href="#section-04-password-generation-and-shell-script-arguments">[ ↥ Back To Top ]</a></b>
</div>
<br/>

## [Project 02] Random Password

### Goal and Scenario

<br/>
<div align="right">
  <b><a href="#section-04-password-generation-and-shell-script-arguments">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### Shell Script Requirements

<br/>
<div align="right">
  <b><a href="#section-04-password-generation-and-shell-script-arguments">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### Solution

<br/>
<div align="right">
  <b><a href="#section-04-password-generation-and-shell-script-arguments">[ ↥ Back To Top ]</a></b>
</div>
<br/>