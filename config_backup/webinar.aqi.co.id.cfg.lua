-- Plugins path gets uncommented during jitsi-meet-tokens package install - that's where token plugin is located
plugin_paths = { "/usr/share/jitsi-meet/prosody-plugins/" }

VirtualHost "webinar.aqi.co.id"
        -- enabled = false -- Remove this line to enable this host
        authentication = "anonymous"
        -- Properties below are modified by jitsi-meet-tokens package config
        -- and authentication above is switched to "token"
        --app_id="example_app_id"
        --app_secret="example_app_secret"
        -- Assign this host a certificate for TLS, otherwise it would use the one
        -- set in the global section (if any).
        -- Note that old-style SSL on port 5223 only supports one certificate, and will always
        -- use the global one.
        ssl = {
                key = "/etc/prosody/certs/webinar.aqi.co.id.key";
                certificate = "/etc/prosody/certs/webinar.aqi.co.id.crt";
        }
        -- we need bosh
        modules_enabled = {
            "bosh";
            "pubsub";
            "ping"; -- Enable mod_ping
	    "token_moderation";
        }

        c2s_require_encryption = false

Component "conference.webinar.aqi.co.id" "muc"
    storage = "null"
    --modules_enabled = { "token_verification" }
admins = { "focus@auth.webinar.aqi.co.id" }

Component "jitsi-videobridge.webinar.aqi.co.id"
    component_secret = "@fw8RIjT"

VirtualHost "auth.webinar.aqi.co.id"
    ssl = {
        key = "/etc/prosody/certs/auth.webinar.aqi.co.id.key";
        certificate = "/etc/prosody/certs/auth.webinar.aqi.co.id.crt";
    }
    authentication = "internal_plain"

Component "focus.webinar.aqi.co.id"
    component_secret = "RlnAoeAl"
