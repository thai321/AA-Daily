# CSS Notes

----
## Display

- **Block**:
  - respect width and height
  - take up 100% of parent element
- **Inline**:
  - do not respect width or height
  - are as large as largest descendant
- **Inline-block**:
  - respects width and height
  - as large as largest descendant

-----

## Content Box vs Border Box
- How to give size to the element in the document flow

- **Content Box**:
  - size includes only the content




- **Border Box**:
  - size includes content, padding, and border
  - Ex:
```css
.col {
  box-sizing: border-box;
  width: 100px;
}
```
  - they will stack horizontal as expected
  - Good for grid system


------

## Float

- The element is placed along the left or right side of its container
- Text and inline elements wrap around the element
- The element is taken from the normal flow of the web page, though still remaining a part of the flow

- Ex:

```css
.float {
  .thumbnail {
    margin: 0 10px 10px 0;
    float: left;
  }

  img {
    height: 100%;
    object-fit: cover;
  }
}

.clearfix:after {
  content: '';

  /*take up 100% of width of their parent's container*/
  display: block;


  /*no float element can pass the element*/
   clear: both;
}
```



------

## Flex Box

- Easily lay out, align and distribute space among items in a container
- The container alters its items to best fill its space
- Viste site `css tricks guide` as working on the project

- Ex:

```css
nav {
  display: flex;

  /* how to vertically center elements */
  align-items: center;

  /* how these elements will be distributed horizontally */
  justify-content: center;

  margin: 20px;
}

.columnize {
  flex-direction: column;
  align-items: center;
  /*put the elment in the center,
  and vertically display them
  */
}

.centered {
  justify-content: center;
  height: 400px;
}




/* Order */
.order {
  display: flex;
}

.flex-item {
  padding: 10px;
  margin: 10px;

  background-color: $light-blue;
  color: $pink;
  font-size: 100px;
}

.flex-item:nth-last-of-type(1) { order: 3;}
.flex-item:nth-last-of-type(2) { order: 4;}
.flex-item:nth-last-of-type(3) { order: 1;}
.flex-item:nth-last-of-type(4) { order: 5;}

/*
Before: 1 2 3 4
After:  3 1 2 4

Game: site --> flex box frog
*/

```

-----

## Grid
- Use them!
- float or flex
- Ex:

```css

/* Grid float */

.col {
  float: left;
  box-sizing: border-box;
}

[class*='col-'] {
  padding-right: 20px;
}

[class*='col-']:last-of-type {
  padding-right: 0;
}

.col-2-3 {
  width: 66.6666%;
}

.col-1-2 {
  width: 50%;
}

.col-1-3 {
  width: 33.3333%;
}

.col-1-4 {
  width: 25%;
}

.col-1-8 {
  width: 12.5%;
}



/* Same effect using flex Box */

.grid {
  display: block;
}

.grid .content {
  display: flex;
}


[class*='col-'] {
  padding-right: 20px;
  margin-right: 10px;
}

[class*='col-']:last-of-type {
  padding-right: 0;
}

.col-2-3 {
  width: 66.6666%;
}

.col-1-2 {
  width: 50%;
}

.col-1-3 {
  width: 33.3333%;
}

.col-1-4 {
  width: 25%;
}

.col-1-8 {
  width: 12.5%;
}

```


-----

## Position
- 4 ways to position the element
- **static**
- **relative**
- **fixed**
- **absolute**

- **Static**:
  - Static (default) this is how elements are positioned by default
  - Sit in the flow of the document
  - **You can't modify the position of a static element by using left, top, bottom, or right relative**
- **Relative**
  - Occupies space in the flow of the page.
  - **Positioned relative to its normal position.
    - this means you can reposition it by using left, top, etc**

- **Fixed**:
  - Positioned relative to the viewport
    - The lement stays in the same place in the viewport; it is not affected by scrolling
  - Fixed elements are taken out of flow (they take up no space in the page)
  - You can adjust their locaiton on the page by using left, top, etc.
- **Absolute**:
  - Positioned with respect to its most recent non-statically positioned ancestor.
  - You can adjust their locaiton on the page by using left, top, etc
  - drop down menu



- Ex:

```css
.dropdownlink {
  position: relative;
}
```



-------------

## 02-css-display
- None
- Block
- Inline

```css
.body {
  background: gray;
}

/* not render on the page */
.none {
  display: none;
}


/* strech out to the full width
- Take full width, but minimum height
- They stack up on top of one another without padding
- Use for building block of the layout
*/
.block {
  display: block;
  background: pink;
}



/*
- Take minimum width and height
- They align next to each other, and responsive
- Use for hightlight words in a paragraph
*/
.inline {
  display: inline-block;
}

```


-----
## 03-css-Box-model

- Block
```css
body {
  background: orange;
}


/*  200 + 20+ 20 + 10 + 10 = 260px */
/* this is border-box property */
.box {
  display: block;
  background: lightblue;

  width: 200px;
  height: 200px;

  padding: 20px;

  border: 10px solid black;

  margin: 100px;
}

```


- Inline
```css

body {
  background: pink;

}

p {
  display: block;
  background: orange;
}

strong {
  display; inline;
  background: yellow;

 /* Can't put width and height on inline element*/
 /*  Does not work */
  width: 200px;
  height: 200px;


  /*  */
  padding: 50px;

  border: 5px solid blue;
}

```
- Fuild Float Grid

```css

h1, h2, ul {
  margin: 0;
}

ul {
  list-style: none;
  padding: 0;
}

/* Layout */

body {
  font-family: sans-serif;
  background: url('htpp//...');
}

header, aside, section {
  background; rgba(0,0,0,0.3)
}


header ul li {
  float: left;
}

.cf:after {
  content: '';
  clear: both;
  display: block;
}

```
