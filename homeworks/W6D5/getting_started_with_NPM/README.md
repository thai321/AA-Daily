# Getting Started With Node Package Manager

This homework covers configuration of a new React project. Download the skeleton [here][skeleton].

You will want to refer [the configuration readings][readings-list] throughout.

## Initialize NPM

In your project directory, run:

```
npm init --yes
```

## Install Dependencies

```
npm install --save package1 package2 etc
```

You'll need the following packages:

- `webpack`
- `react`
- `react-dom`
- `babel-core`
- `babel-loader`
- `babel-preset-es2015`
- `babel-preset-react`

## Configure Webpack

Create `webpack.config.js` and assign `module.exports` to the Webpack configuration object.
Make sure to do the following:

- Set your entry and output files.
- Configure Babel transpilation of React and ES6 syntax
- Add a `devtool`
- Ensure that `.js` and `.jsx` files resolve automatically

In the generated `package.json`:

- Add a `webpack` script for webpack to your `package.json` (`"webpack": "webpack --watch"`)
- Create a `.gitignore` for your node modules and bundled files

## Boot it Up!

Run `npm run webpack` in your terminal, then open `index.html`. Congratulations:
you're up and running!

[readings-list]: ../../README.md#readings-48-min
[skeleton]: skeleton.zip?raw=true
