import http from "http";

/**
 * 🛰️ STANDALONE RPC ENGINE for FLORESTA
 * Migrated from precop-indexer for V38 Standalone Sovereign Node.
 */
const RPC_URL = process.env.RPC_URL || "http://127.0.0.1:8332";
const rpcAgent = new http.Agent({ keepAlive: true, maxSockets: 100 });

export async function callRPC(method: string, params: any[] = []): Promise<any> {
    const body = JSON.stringify({ jsonrpc: "1.0", id: "precop-standalone", method, params });
    const auth = Buffer.from(`${process.env.RPC_USER || "floresta"}:${process.env.RPC_PASSWORD || "8e5cde5295800d10b02b297085832da9"}`).toString("base64");
    
    return new Promise((resolve) => {
        const req = http.request(RPC_URL, {
            method: "POST", agent: rpcAgent, timeout: 5000,
            headers: { 
                "Content-Type": "application/json",
                "Authorization": `Basic ${auth}`
            }
        }, (res) => {
            let data = ""; res.on("data", (chunk) => data += chunk);
            res.on("end", () => {
                try { resolve(JSON.parse(data)); }
                catch (e) { resolve({ error: "PARSE_ERROR" }); }
            });
        });
        req.on("error", (e) => resolve({ error: e.message }));
        req.write(body); req.end();
    });
}
