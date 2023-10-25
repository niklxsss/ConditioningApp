import SwiftUI
import FamilyControls
import DeviceActivity

class ScreenTimeModel: ObservableObject {
    @Published var activitySelection = FamilyActivitySelection()
    
    func startMonitoring() {
        let schedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0, second: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
            repeats: true
        )
        
        let event = DeviceActivityEvent(
            applications: activitySelection.applicationTokens,
            categories: activitySelection.categoryTokens,
            webDomains: activitySelection.webDomainTokens,
            threshold: DateComponents(minute: 1)
        )
        
        let activityCenter = DeviceActivityCenter()
        let activityName = DeviceActivityName("MeineApp.ScreenTime")
        let eventName = DeviceActivityEvent.Name("MeineApp.ScreenTimeEvent")
        
        print(activitySelection.applications)
        
        do {
            try activityCenter.startMonitoring(
                activityName,
                during: schedule,
                events: [eventName: event]
            )
            print("Monitoring gestartet")
            
                        
        } catch {
            print("Fehler beim Starten des Monitorings: \(error)")
        }
    }
}
class MyMonitorExtension: DeviceActivityMonitor {

    override func eventWillReachThresholdWarning(
        _ event: DeviceActivityEvent.Name,
        activity: DeviceActivityName
    ) {
        super.eventWillReachThresholdWarning(event, activity: activity)
        print("activity event triggert")

        // Notify the user that they're approaching the time limit
        
        let schedule = DeviceActivityCenter().schedule(for: activity)
        let warningTime = schedule?.warningTime

    }
}
