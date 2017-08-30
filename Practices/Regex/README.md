# Regex Practice

- From https://regexone.com/

-------
### Lesson 1: An Introduction, and the ABCs

- **Regular expressions** are extremely useful in extracting information from text such as code, log files, spreadsheets, or even documents. And while there is a lot of theory behind formal languages, the following lessons and examples will explore the more practical uses of regular expressions so that you can use them as quickly as possible.

- The first thing to recognize when using regular expressions is that **everything is essentially a character**, and we are writing patterns to match a specific sequence of characters (also known as a string). Most patterns use normal ASCII, which includes letters, digits, punctuation and other symbols on your keyboard like %#$@!, but unicode characters can also be used to match any type of international text.

- Below are a couple lines of text, notice how the text changes to highlight the matching characters on each line as you type in the input field below. To continue to the next lesson, you will need to use the new syntax and concept introduced in each lesson to write a pattern that matches all the lines provided.

#### Exercise 1: Matching Characters

- Match: **abc**defg
- Match: **abc**de
- Match: **abc**
- **Pattern**: abc

-------

### Lesson 1½: The 123s
- Characters include normal letters, but digits as well. In fact, numbers 0-9 are also just characters and if you look at an ASCII table, they are listed sequentially.

- Over the various lessons, you will be introduced to a number of special metacharacters used in regular expressions that can be used to match a specific type of character. In this case, the character **\d** can be used in place of **any digit from 0 to 9**. The preceding slash distinguishes it from the simple **d** character and indicates that it is a metacharacter.

- Below are a few more lines of text containing digits. Try writing a pattern that matches all the digits in the strings below, and notice how your pattern matches **anywhere within the string**, not just starting at the first character. We will learn how to control this in a later lesson.

#### Exercise 1½: Matching Digits
- Match:	abc123xyz
- Match:	define "123"
- Match:	var g = 123;
- **Pattern:**  123
