/// <reference path="node_modules/vitest/node.d.ts" />
import { defineConfig } from "vite";

// https://vitejs.dev/config/
export default defineConfig({
	build: {},
	server: {
		watch: {
			ignored: ["**/.direnv"],
		},
	},
	test: {
		exclude: [".direnv"],
	},
});
