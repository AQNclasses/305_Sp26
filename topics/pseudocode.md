# **Expressing algorithms**

We express algorithms in whatever way is the clearest and most concise.

English is sometimes the best way.

When issues of control need to be made perfectly clear, we often use *pseudocode*.

- Pseudocode is similar to C, C++, Java, Python, JavaScript, and many other frequently used programming languages. If you know any of these languages, you should be able to understand pseudocode.
- Pseudocode is designed for *expressing algorithms to humans*. Software engineering issues of data abstraction, modularity, and error handling are often ignored.
- We sometimes embed English statements into pseudocode. Therefore, unlike for "real" programming languages, we cannot create a compiler that translates pseudocode to machine code.

### **Pseudocode conventions**

- Indentation indicates block structure. Saves space and writing time.
- We indent **else** at the same level as its matching **if**. The first executable line of an **else** clause appears on the same line as the keyword **else**. Multiway tests use **elseif** for tests after the first one. When an **if** statement is the first line in an **else** clause, it appears on the line following **else** to avoid it being misconstrued as **elseif**.
- Looping constructs are like in C, C++, Java, Python, and JavaScript. We assume that the loop variable in a **for** loop is still defined when the loop exits and has the value it had that caused the loop to terminate (such as i = n + 1 in INSERTION-SORT.)
- `//` indicates that the remainder of the line is a comment.
- Variables are local, unless otherwise specified.
- We often use *objects*, which have *attributes*. For an attribute *attr* of object *x*, we write *x.attr*. (This notation matches *x.attr* in many object-oriented languages and is equivalent to *x->attr* in C++.) Attributes can cascade, so that if *x.y* is an object and this object has attribute *attr*, then *x.y.attr* indicates this object's attribute. That is, *x.y.attr* is implicitly parenthesized as (*x.y*). *attr*.
- Objects are treated as references, like in most object-oriented languages. If x and y denote objects, then the assignment y = x makes x and y reference the same object. It does not cause attributes of one object to be copied to another.
- Parameters are passed by value. When an object is passed by value, it is actually a reference (or pointer) that is passed; changes to the reference itself are not seen by the caller, but changes to the object's attributes are.
- **return** statements are allowed to return multiple values to the caller (as Python can do with tuples).
- The boolean operators "and" and "or" are *short-circuiting*: if after evaluating the left-hand operand, we know the result of the expression, then we don't evaluate the right-hand operand. (If x is FALSE in "x and y" then we don't evaluate y. If x is TRUE in "x or y" then we don't evaluate y.)
- **error** means that conditions were wrong for the procedure to be called. The procedure immediately terminates. The caller is responsible for handling the error. This situation is somewhat like an exception in many programming languages, but we do not want to get into the details of handling exceptions.
