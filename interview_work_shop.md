### Interview

#### Connection
Asks questions about you or your career
- Why do you want to work for our company?
- What do you like about software/tech?
- What are you 5 year career goals?

- Developer Personality Questions
  - What have you been learning ...


2 types: techinal and behavior
  - What is a Behaviroal question?
    - Asks about the way you've handled projects in the past.
      - May start ith "Tell me about a time when..." or similar.
      - Request for concrete examples from your past.
  - Ex:
    - Tell me about a challenge you ran into on that project ...

  - Communicating an Image.
    - Tell a story!
      - A story has a beginning, middle, and end.
      - includes where/whe.
      - ...
- P. A. R : Problem, Action, Resolve



### Algorithms and Data Structures
 You have a linked list and you want to find the kth to last. node. Write a function kth_to_last_node that takes an integer k and the head_node of a linked list, and returns the kth to the last node in the list.


- What are some clarifying questions fro this linked list problem?
  - Is head null
  - single linked list or double linked list
  - does num greater than the total nodes in the linked list


```ruby

def func(head, num)
  start = head
  current = head
  k = 0

  while(current != null && current.next != nil && k < num)
    current = current.next
    k = k+1
  end

  return current

end
```


- Example I/O & Edge Cases
  - "Test throughout!"
  - Designated top left corner

```ruby
 A -> B -> C -> D -> nil

func(A, 0) = D
func(A, -2) = nil
func(A, 4) =nil
funct(A, 2) = 2

```


- Plan: Brainstorm
  - Brainstorm different approaches
    - "Do you mid if I brainstorm out loud for a bit?"
  - Write out the different approaches in English; not even pseudocode yet!


- hash variable, key is index and value is the node
- iterator through the linked list and add the index and current node to the hash.
- i variable to keep track of the current index, so at the end of the iteration, i is the total length of the linked list
- return hash[length - k] to get the k-th to last node


- Pseudocode:
```
h = {}
i = 0
current = head

while(head and head.next is not nil)
  h[i] = current
  current = current.next
  i++
end

return h[i-k]

```

```ruby
h = {}
i = 0
current = head

while(head != nil and head.next != nil)
  h[i] = current
  current = current.next
  i++
end

return h[i-k]
```


```
h = {}
i = 0

current = head
nextNode = head.next

while(nextNode and current.next is not nil)
  h[i] = current
  current = current.next
  nextNode = current.next
  i++

end

return h[i-k]
```

Solution: use 2 pointer, second pointer is k differnt than the 1st pointer.


### Algorithms/ Data Structure - How to Prep
- 2 Cracking the coding interview or elements of Programming Interview problems each day
- 1 Leetcode or Hackerrank problem per day
- Practice live and often - 2 Pramp Interviews per Week
- Take notes on your own practice & study - what techniques are you using? When do you use them?
- Other great resources: Codility, InterviewCake, MIT, Stanford, Princeton, Coursera



### KNowledge/Trivia - General Overview
1. "Do you have a baseline understanding of various important subjects in web development and can you communicate your understanding well?"
2. JavaScript, Rails, Ruby, SQL, HTML/CSS, React/Redux


-----
Ex:
1. What is the event loop? How does it work?
2. Tell me about the differences between ES5 and ES6
3. "Lightning Rounds":
  - Talk about the 4 types of positions in CSS
  - What is HTTPS, and how is it different from HTTP?
  - What's a ring buffer?
  - What's ur favorite thing about ...
-----
#### How to do well
- Structure your responses:
  - Don't rush. Take a couple of moments to think
  - Thesis statement: "The event loop is essentially a queue of callback functions. To fully explain the event loop, we have to understand how the JavaScript call stack works, how async functions are executing, and then finally how the event loop handles those callback functions."
- Use an example to illustrate the idea
  - Example should be small and show benefits of tool/concept
-----
#### How to Prep
- Perpping:
  - review Instructional Curriculum (but not in its entirety! Be efficient.)
    - Recommended review order: javaScript, SQL, React/Redux, Rails
  - After-curriculum Resources (App Academy github)
    - https://github.com/h5bp/Front-end-Developer-Interview-Questions
------
### Practical - General Overview
- Build something
- Make calls to an API
- Debug
- Refactor

------
#### Example
1. Build a React component that prints ""...
2. Here is a broken code, fix it
...

-----
#### How to Do well
- Waste as little itme as possible on setup-practice writing biolerplate code
- Commumnicate well- remember your pair programming experience!
- Remember to test(don't wait until you've coded up the entire problem before testing ...)
-----
- Keep coding - don't let your skills get stale: recommended 1.5 hours of working on projects or practical coding challenges per day.
- Focus on deepening your understanding as you code (ie. Don't just Stack Overflow, shrug, and move on.)
- https://javascript30.com
- Hackathons


-------
### Arch/System Design - General Overview
- Often big, vague, broad questions
- Often times more pseudocode and high level discussion than actual code writing
- Looking....

-------
#### How to do well
- Start with making sure you understand the end goal
- Make it conversational
- Diagrams and visuals (user whiteboard or paper)

- Read 1 high Scalability article per day to get acquainted with the different tools available and their strengths/waknesses. For example, what is a NoSQL database, Why use one? What it strengths and weaknesses ? (as you read, research the topics you're not familiar with, make flashcards out of them)
- 30 minutes per day of studying the arch/system design resources in after -curriculum repo


-----
#### Afther the Interview
- Always do a debrief
  - What questions did you struggle with and why?
  - What topics came up? G one level deeper with each
  - Interview-db
- Get feeback....

-----
#### Success in the long return
- "What did they do to be successful?"
  - Disciplined
  - Put themselves out there
  - The opposite of doom loop
- Come up with a study schedule (5 minutes)
- Growth Mindset
- Constant Reflection
- Aggressive, Not Passive
