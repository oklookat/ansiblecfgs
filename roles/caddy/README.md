# note for proxy fallback

as i understand, reality_sfy required certbot, cuz caddy running behind proxy engine (xray, sing-box, etc).

so acme challange requires 80 or 443 port, but it occupied by proxy engine.

we need certbot standalone, with hooks to stop and start Caddy for running certbot server, for manual certificates obtaining, but for what this complexity? we have nginx.

i do porting nginx to caddy maybe later, but for now i dont see sense for this.
