import DeviceActivity


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
