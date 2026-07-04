import { readFileSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";
import pg from "pg";

const __dirname = dirname(fileURLToPath(import.meta.url));

const { Pool } = pg;

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.DATABASE_URL?.includes("localhost") ? undefined : { rejectUnauthorized: false },
});

async function runFile(filePath) {
  const sql = readFileSync(filePath, "utf-8");
  const statements = sql
    .split(";")
    .map((s) => s.trim())
    .filter((s) => s.length > 0 && !s.startsWith("--"));

  console.log(`\n>>> Executando ${filePath.split("/").pop()} (${statements.length} statements)`);

  for (const stmt of statements) {
    try {
      await pool.query(stmt + ";");
      console.log("  ✓");
    } catch (err) {
      console.error(`  ✗ ERRO: ${err.message}`);
    }
  }
}

async function main() {
  const sqlDir = join(__dirname, "..", "sql");
  const files = [
    "001-schema.sql",
    "002-rls.sql",
    "003-seed-lgpd.sql",
    "004-seed-iso27001.sql",
  ];

  for (const file of files) {
    await runFile(join(sqlDir, file));
  }

  await pool.end();
  console.log("\n✔ Setup concluído!");
}

main().catch((err) => {
  console.error("Falha no setup:", err);
  process.exit(1);
});
