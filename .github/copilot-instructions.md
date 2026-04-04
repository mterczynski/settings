# GitHub Copilot Instructions 🤖

Generic TypeScript instructions for all repositories.

## 🛠️ Code Style & Formatting

- Always use **Prettier** for code formatting and **ESLint** for linting. 🎨
- If Prettier or ESLint are **not present** in the project, recommend adding them and suggest a basic configuration. 📋
- Follow consistent code style enforced by these tools — never bypass or disable rules without a good reason.
- Prefer single quotes for strings (as per typical Prettier/ESLint TS config).

## 📦 TypeScript Best Practices

- Always use **strict TypeScript** — enable `strict: true` in `tsconfig.json`. 💪
- Prefer `const` over `let`; avoid `var` entirely. 🚫
- Use explicit return types for functions, especially public APIs. 📝
- Avoid `any` — use proper types, generics, or `unknown` instead. ✅
- Use interfaces or type aliases to describe object shapes clearly. 🧩
- Leverage optional chaining (`?.`) and nullish coalescing (`??`) operators. 🔗

## 🐛 Debugging

- When adding debug logs, use `console.log` with a **`## DEBUG`** prefix followed by an emoji, for easy filtering in the browser console: 🔍

  ```ts
  console.log('## DEBUG 🐛', someVariable);
  console.log('## DEBUG 🔥', 'reached this point');
  console.log('## DEBUG 📦', { data });
  ```

- Remove all `## DEBUG` logs before committing or opening a pull request. 🧹
- For production logging, use a proper logging library rather than raw `console.log`.

## 🧪 Testing

- Write unit tests for all business logic. ✅
- Prefer **Jest** as the test runner for TypeScript projects. 🃏
- Test file names should mirror the source file: `foo.ts` → `foo.test.ts`. 📂
- Aim for meaningful assertions — avoid trivial tests that add no value. 🎯

## 🏗️ Project Structure

- Keep files small and focused — one responsibility per file. 🗂️
- Group related files by feature rather than by type where possible. 📁
- Use barrel files (`index.ts`) to simplify imports within modules. 📤

## 🔄 Git & Pull Requests

- Write clear, descriptive commit messages. ✍️
- Keep pull requests small and focused on a single concern. 🔬
- Include tests with every feature or bugfix PR. 🧪

## 💬 General Guidelines

- Use emojis in comments, documentation, and log messages to make them more readable and fun! 🎉
- Prefer readability over cleverness — code is read more often than it is written. 📖
- Document non-obvious logic with concise inline comments. 💡
