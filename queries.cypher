// 2.1 Find Entities by Property
MATCH (device:Device { mac: 'AA:BB:CC:DD:EE:04' })
RETURN device;

// 2.2 Find Entities by Relationship
MATCH (device:Device)-[:LOCATED_IN]->(location:Location { name: 'Headquarters' })
RETURN device;

// 2.3 Find Entities Connected by Deep Relationships
MATCH path = (startDevice:Device { name: 'Router1' })-[:CONNECTED_TO*..10]-(endDevice:Device)
WHERE startDevice <> endDevice
RETURN endDevice AS ConnectedDevice, LENGTH(path) AS NumberOfHops;

// 2.4 Find Shortest Path Considering Weights (actually 2.5 as well)
MATCH (start:Device { mac: 'AA:BB:CC:DD:EE:04' })
MATCH (end:Device { mac: 'AA:BB:CC:DD:EE:06' })
MATCH path = shortestPath((start)-[rels:CONNECTED_TO*..10]-(end))
RETURN path, reduce(totalLatency = 0, r in rels | totalLatency + r.latency_ms) AS totalLatency

// 2.5 Aggregate Data
MATCH (d:Device)-[:LOCATED_IN]->(l:Location { name: 'Headquarters' })
RETURN COUNT(d) AS NumberOfDevices;
