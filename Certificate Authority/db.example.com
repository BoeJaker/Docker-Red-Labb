$TTL 1h
@       IN SOA  ns1.example.com. admin.example.com. (
                2023021501      ; serial number
                1d              ; refresh
                1h              ; retry
                1w              ; expire
                1h              ; minimum
                )
        IN NS   ns1.example.com.

ns1     IN A    172.16.0.1
koan   IN A    172.16.0.2
houston   IN A    172.16.0.3
postgres   IN A    172.16.0.4