import formsPlugin from "@tailwindcss/forms";

/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        primary: {
          50: "#f4f9f8",
          100: "#daede8",
          200: "#b5dad1",
          300: "#88c0b4",
          400: "#5fa295",
          500: "#46867b",
          600: "#366b63",
          700: "#2e5752",
          800: "#284743",
          900: "#253c3a",
          950: "#0c1817",
        },
      },
    },
  },
  plugins: [formsPlugin],
};
