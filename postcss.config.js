module.exports = {
  plugins: [
    //...
    require('postcss-import'),
    require("tailwindcss"),
    require('postcss-nested'),
    require("autoprefixer"), 
    require("postcss-preset-env")({
      autoprefixer: {
        flexbox: "no-2009",
      },
      stage: 3,
    }),
  ],
};

if (process.env.RAILS_ENV === "production") {
  environment.plugins.push(
    require('@fullhuman/postcss-purgecss')({
      content: [
        './app/**/*.html.erb',
        './app/**/*.js.erb',
        './app/helpers/**/*.rb',
      ],
      safelist: ['a'],
      defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || []
    })
  )
}