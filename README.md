# Stress test

* Delay between iterations: 1ms
* Request timeout: 30s

|Request per iteration|Phoenix|Spring Boot|Difference|
|---|---|---|---|
|6|650ms|760ms|110ms|
|12|1.328s|1.496s|168ms|
|24|2.561s|2.955s|390ms|
|48|5.296s|5.936s|640ms|
|92|10.214s|11.832s|1.618s|
