## CSS Flex Exercise

Download this [skeleton][skeleton].

[skeleton]: ./skeleton.zip

Starting from the skeleton, update the the `flex.css` stylesheet. In this exercise, we will be converting yesterday's solution from using floats to using flexbox. Let us begin. 🙏

1. First, let's remove the `clearfix` class from our `header` as it won't play well with flex.
2. Next, we should unfloat our logo image and our `nav`, and remove the `inline-block` display property from the list items in our `nav`.
3. Now that we've undone our beautiful styling we can call flex to our aid! Let's add `display: flex` to our `header` and see what happens.
4. Our logo and nav links should be side-by-side now since they're both children of our header. Now figure out which element needs `display: flex` for our individual nav links to appear side-by-side.
5. The last thing we need is more space between our logo and our nav links. Give our header `justify-content: space-between` so that it arranges its children just the way we want.

Download the [solution][solution] to compare your work to ours.

[solution]: ./solution.zip?raw=true
