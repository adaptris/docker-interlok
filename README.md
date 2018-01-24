# docker-adapter-hpcc
Basic Docker image of the adapter with HPCC client tools.

* Exposes ports 8080 + 5555 + 7100
* Interlok installed to /opt/interlok
* HPCC Client Tools installed to /opt/HPCCSystems
* Volumes : /opt/interlok/config /opt/interlok/logs /opt/interlok/ui-resources


## Running

```
docker run --rm -it -p 8080:8080 -p 7100:7100 -p 5555:5555 adaptris/interlok:develop-centos-hpcc
```

## Config

```
<standalone-producer>
  <unique-id>spray-to-thor</unique-id>
  <connection class="dfuplus-connection">
    <unique-id>dfuplus-connection</unique-id>
    <dfuplus-command>/opt/HPCCSystems/6.4.6/clienttools/bin/dfuplus</dfuplus-command>
    <server>http://${server.ip}:8010</server>
    <source-ip>${source.ip}:7100</source-ip>
  </connection>
  <producer class="spray-to-thor">
    <destination class="configured-produce-destination">
      <destination>interlok::csv::data</destination>
    </destination>
    <cluster>mythor</cluster>
    <format>CSV</format>
    <max-record-size>8192</max-record-size>
  </producer>
</standalone-producer>
```
