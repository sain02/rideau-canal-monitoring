# Rideau Canal Skateway – Real-Time Monitoring System  
**CST8916 – Remote Data and Real-time Applications**  
**Final Project – Documentation Repository**

## Student Information
- **Name:** Saizal Saini  
- **Student ID:** 041168394  
- **Course:** CST8916 – Fall 2025  

---

# 1. Project Overview  

The Rideau Canal Skateway in Ottawa requires continuous safety monitoring during the winter season.  
This project simulates IoT sensors, processes data in real-time using Azure Stream Analytics, stores results in Cosmos DB and Blob Storage, and displays a real-time dashboard hosted on Azure App Service.

This repository contains:  
- Full project documentation  
- Architecture diagram  
- Screenshots of all Azure components  
- Stream Analytics query  
- Links to all GitHub repositories  
- Video demo link  

---

# 2. Scenario Overview  

The National Capital Commission (NCC) needs a real-time monitoring system that tracks environmental conditions at three locations:

- **Dow's Lake**  
- **Fifth Avenue**  
- **NAC**

Sensors generate readings every **10 seconds** for:
- Ice Thickness (cm)  
- Surface Temperature (°C)  
- Snow Accumulation (cm)  
- External Temperature (°C)

The system must evaluate safety conditions using Azure Stream Analytics and store processed data.

---

# 3. System Architecture  

### **Architecture Diagram**
*(place image inside `c:\Users\Owner\Pictures\Screenshots\Screenshot 2025-12-08 120254.png`)*

### **Data Flow**
1. **Python IoT Sensors** send telemetry to **Azure IoT Hub**.  
2. **Azure Stream Analytics** processes telemetry in **5-minute tumbling windows** and evaluates safety:
   - Safe  
   - Caution  
   - Unsafe  
3. Results flow to:
   - **Azure Cosmos DB** → Real-time dashboard reads from here  
   - **Azure Blob Storage** → Historical archival  
4. **Node.js Dashboard** queries Cosmos DB via API and updates UI every 30 seconds.  
5. Dashboard deployed on **Azure App Service**.

---

# 4. Azure Services Used  

| Service | Purpose |
|--------|---------|
| **IoT Hub** | Ingests raw sensor data |
| **Stream Analytics** | Computes averages, min/max, and safety status |
| **Cosmos DB** | Stores real-time processed aggregations |
| **Blob Storage** | Archives historical JSON snapshots |
| **App Service** | Hosts the dashboard website |

---

# 5. Implementation Overview  

## 5.1 IoT Sensor Simulation  
Repository: **rideau-canal-sensor-simulation**  
Simulates 3 sensors sending JSON telemetry to IoT Hub.

## 5.2 Azure IoT Hub Setup  
- Created IoT Hub  
- Registered 3 IoT devices  
- Connected Python simulator using device connection strings  

## 5.3 Stream Analytics Job  
- Input: IoT Hub  
- Outputs: Cosmos DB + Blob Storage  
- **Window:** 5-minute tumbling  
- Query included in `/stream-analytics/query.sql`

## 5.4 Cosmos DB Setup  
- Database: `RideauCanalDB`  
- Container: `SensorAggregations`  
- Partition Key: `/location`  
- Stores aggregated results + safety status  

## 5.5 Blob Storage Setup  
- Container: `historical-data`  
- ASA stores JSON files using date-based paths  

## 5.6 Dashboard Backend & Frontend  
Repository: **rideau-canal-dashboard**  
- Node.js Express backend  
- Chart.js frontend  
- Auto-refresh every 30 seconds  
- Deployed to Azure App Service  

---

---
### THANKS


