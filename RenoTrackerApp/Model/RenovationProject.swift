import Foundation

struct RenovationProject: Codable {
    var projectNumber: Int = 0
    var renovationArea: String = ""
    var imageName: String = ""
    var dueDate: Date = Date.distantFuture
    var lastProgressUpdate: Date? = nil
    var workQuality: WorkQualityRating = .na
    var isFlagged: Bool = false
    var punchList: [PunchListItem] = []
    //Budget
    var budgetAmountAllocated: Double = 0.0
    var budgetSpentToDate: Double = 0.0

    var inspectionLog: [InspectionLogEntry] = []

   
    //Work quality
    enum WorkQualityRating: String, Codable, CaseIterable {
        case na = "N/A"
        case poor = "Poor"
        case fair = "Fair"
        case good = "Good"
        case excellent = "Excellent"
        
        init(from decoder: Decoder) throws {
            let container = try? decoder.singleValueContainer()
            let status = try container?.decode(String.self)
                
            switch status {
            case "N/A": self = .na
            case "Poor": self = .poor
            case "Fair": self = .fair
            case "Good": self = .good
            case "Excellent": self = .excellent
            default: self = .na
            }
        }
    }
}

//Punch list
struct PunchListItem: Codable, Hashable {
    
    var task: String = ""
    var status: CompletionStatus = .notStarted
    
    enum CompletionStatus: String, Codable, CaseIterable {
        case notStarted = "Not Started"
        case inProgress = "In Progress"
        case complete = "Complete"
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let status = try container.decode(String.self)
            
            switch status {
            case "Not Started": self = .notStarted
            case "In Progress": self = .inProgress
            case "Complete": self = .complete
            default: self = .notStarted
            }
        }
    }
}

struct InspectionLogEntry: Codable {
    var entryDate: Date
    var details: String
    
    
}
extension RenovationProject {
    static var testData: [RenovationProject]
    {
        let dateFormatter =  DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return [
            RenovationProject( projectNumber: 2021001,
                              renovationArea: "Front Lobby",
                              imageName: "front-lobby",
                              dueDate: dateFormatter.date(from: "2021-08-01")!,
                              lastProgressUpdate:  dateFormatter.date(from: "2021-05-28")!,
                              workQuality: .good,
                              isFlagged: false,
                              punchList: [
                                PunchListItem(task: "Remodel front desk", status: .complete),
                                PunchListItem(task: "Retail entry", status: .complete),
                                PunchListItem(task: "Replace light fixtures", status: .complete),
                                PunchListItem(task: "Paint walls", status: .inProgress),
                                PunchListItem(task: "Hang new artwork", status: .notStarted)
                              ],
                              budgetAmountAllocated: 15000,
                              budgetSpentToDate: 18530.0,
                              inspectionLog: [
                                InspectionLogEntry(entryDate: Date().advanced(by: -1), details: "Test entery 1")]
                             )]
    }
}
 
    

