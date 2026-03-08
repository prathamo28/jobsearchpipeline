// Writes config.js from env vars (used by Vercel so keys are not in the repo)
const fs = require('fs');
const path = require('path');
const url = (process.env.SUPABASE_URL || '').replace(/'/g, "\\'");
const anon = (process.env.SUPABASE_ANON || '').replace(/'/g, "\\'");
const out = path.join(__dirname, '..', 'config.js');
fs.writeFileSync(out, `// Generated at build time — do not commit with real keys\nwindow.SUPABASE_URL = '${url}';\nwindow.SUPABASE_ANON = '${anon}';\n`);
console.log('Wrote config.js');
