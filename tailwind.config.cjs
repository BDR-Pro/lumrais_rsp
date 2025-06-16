const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './app/views/**/*.{erb,haml,html,slim}',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [require("daisyui")],
  daisyui: {
    themes: [
      {
        light: {
          primary: "#10b981", // emerald-500
          "primary-focus": "#059669", // emerald-600
          "primary-content": "#ffffff",
        },
        dark: {
          primary: "#10b981", // emerald-500
          "primary-focus": "#059669", // emerald-600
          "primary-content": "#ffffff",
        },
      },
    ],
    darkTheme: "dark",
  },
} 