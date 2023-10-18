import DeviceActivity
import SwiftUI
import Foundation
import ManagedSettings
import FamilyControls



/*
func scheduleDeviceActivityEvent(appInfo: AppInfo) {
    let event = DeviceActivityEvent( threshold: DateComponents)
    
    // Setzen Sie die Bundle-ID der App, die das Ereignis auslösen soll.
    event.targetBundleIdentifier = appInfo.getBundleId()
    
    // Setzen Sie die Startzeit auf die aktuelle Zeit.
    event.startDate = Date()
    
    // Setzen Sie das Enddatum auf 5 Minuten nach der aktuellen Zeit.
    event.endDate = Date().addingTimeInterval(5 * 60)
    
    // Optional: Fügen Sie zusätzliche Metadaten hinzu, wenn erforderlich.
    // event.metadata = ...
    
    // Planen Sie das Ereignis.
    DeviceActivityCenter.scheduleEvent(event) { error in
        if let error = error {
            // Behandeln Sie Fehler, die beim Planen des Ereignisses auftreten.
            print("Fehler beim Planen des DeviceActivityEvents: \(error)")
        } else {
            // Das Ereignis wurde erfolgreich geplant.
            print("DeviceActivityEvent erfolgreich geplant.")
        }
    }
}*/

/*func scheduleDeviceActivityEvent(appInfo: AppInfo) {
    // Definieren Sie die Anwendungen, Kategorien und Webdomains, falls zutreffend.
   
    guard let application = Application(bundleIdentifier: appInfo.getBundleId()) else {
            print("Fehler: Konnte keine Application-Instanz aus der Bundle-ID erstellen.")
            return
        }

    let fiveMinutesFromNow = Calendar.current.date(byAdding: .minute, value: 5, to: Date())!
            let threshold = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: fiveMinutesFromNow)

            // Initialisieren Sie das DeviceActivityEvent.
            let event = DeviceActivityEvent(applications: applications, threshold: threshold)

            // Holen Sie sich die DeviceActivityCenter-Instanz.
            let activityCenter = DeviceActivityCenter()

            // Planen Sie das Ereignis.
            do {
                try activityCenter.scheduleEvent(event)
                print("DeviceActivityEvent erfolgreich geplant.")
            } catch {
                // Behandeln Sie Fehler, die beim Planen des Ereignisses auftreten.
                print("Fehler beim Planen des DeviceActivityEvents: \(error)")
            }
}*/

func scheduleDeviceActivityEvent(appInfo: AppInfo) {
    
    let fiveMinutesFromNow = Calendar.current.date(byAdding: .minute, value: 5, to: Date())!
    let threshold = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: fiveMinutesFromNow)
    
    let schedule = DeviceActivitySchedule(
        intervalStart: DateComponents(hour: 0, minute: 0, second: 0),
        intervalEnd: DateComponents(hour: 0, minute: 2, second: 0), repeats: true,
        warningTime: DateComponents(minute: 1)
    )
    
    let activityname = DeviceActivityName("testname")
   
    
    let application = Application(bundleIdentifier: appInfo.bundleId)
    print(application)
    print(application.bundleIdentifier)
    print(application.token)
    
    //var f =  FamilyActivitySelection().
    
    if let token = application.token {
        let applicationTokens: Set<ApplicationToken> = [token]
        
        let event = DeviceActivityEvent(applications: applicationTokens, threshold: threshold)

        let activityCenter = DeviceActivityCenter()
        
        let eventsDictionary: [DeviceActivityEvent.Name : DeviceActivityEvent] = [DeviceActivityEvent.Name("eventName"): event]

        do {
            try activityCenter.startMonitoring(activityname, during: schedule, events: eventsDictionary)
            print("DeviceActivityEvent erfolgreich geplant.")
        } catch {
            print("Fehler beim Planen des DeviceActivityEvents: \(error)")
        }
        
    } else {
        print("Fehler beim anlegen des tokens")
    }

    
}


/*let schedule = DeviceActivitySchedule(
    intervalStart: DateComponents(hour: 0, minute: 0, second: 0),
    intervalEnd: DateComponents(hour: 23, minute: 59, second: 59),
    warningTime: DateComponents(minute: 1)
)

let selection: FamilyActivitySelection = savedSelection()

let timeLimitMinutes = 30

//bundelid von imessage: com.apple.MobileSMS

let event = DeviceActivityEvent(
    applications: selection.applicationTokens,
    categories: selection.categoryTokens,
    webDomains: selection.webDomainTokens,
    threshold: DateComponents(minute: timeLimitMinutes)
)
let deviceActivityEvent = DeviceActivityEvent(appURL: URL(string: "messages://"), threshold: <#DateComponents#>)
deviceActivityEvent.start()

// Überprüfen Sie, ob das Zeitlimit erreicht wurde
if deviceActivityEvent.timeLimitReached {
    // Führen Sie eine nicht definierte Aktion aus
    print("Time limit reached!")
} else {
    // Überprüfen Sie, ob das Event noch aktiv ist
    if deviceActivityEvent.isActive {
        // Beenden Sie das Event
        deviceActivityEvent.end()
    }
}*/
