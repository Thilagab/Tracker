//
//  DetailView.swift
//  RenoTrackerApp
//
//  Created by Thilagawathy Duraisamy on 31/5/2023.
//

import SwiftUI

struct DetailView: View {
    @State var showEditView: Bool = false
    @Binding var renovationProject: RenovationProject
    @State var renovationProjectForEdit: RenovationProject = RenovationProject()
    
    var body: some View {
        VStack(alignment: .leading) {
     
                Header(renovationProject: renovationProject)

                 WorkQuality(renovationProject: renovationProject)
                 Divider()

            PunchList(renovationProject: $renovationProject, punchListItem: PunchListItem())
                 Divider()

                 Budget(renovationProject: renovationProject)
                .padding(.trailing)
                 Spacer()
        }
        .padding(.leading, 8)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    renovationProjectForEdit = self.renovationProject
                    showEditView = true
                }
            }
        })
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showEditView)
        {
            NavigationView(content: {
                EditView(renovationProject: $renovationProjectForEdit)
                    .toolbar(content: {
                      ToolbarItem(placement: .navigationBarTrailing) {
                          Button("Save") {
                              self.renovationProject = renovationProjectForEdit
                              showEditView = false }}
                      ToolbarItem(placement: .navigationBarLeading) {
                          Button("Cancel") {
                              showEditView = false }}
                    })
                
            })
                 
        }

        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            DetailView(showEditView: false, renovationProject: .constant(RenovationProject.testData[0]))
        }
    }
}

//MARK: Header section

struct Header: View {
    var renovationProject: RenovationProject
    @State var isProgressCard: Bool = false
    var body: some View {
        VStack {
            Text(renovationProject.renovationArea)
                .font(.largeTitle)
                .fontDesign(.serif)
                .bold()
                .foregroundColor(.blue)
            ZStack {
            Image("front-lobby")
                .resizable()
                .scaledToFit()
                .frame(width: 360)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 15)
                .overlay(alignment: .topTrailing) {
//                    Text("FLAGGED FOR REVIEW")
//                        .padding()
//                        .foregroundColor(.white)
//                        .background(Color.black.opacity(0.5))
                    
                    VStack {
                        ZStack {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .padding(.all)
                            
                            
                            Button {
                                withAnimation {
                                    isProgressCard.toggle()
                                }
                                
                            } label: {
                                Image(systemName: "info.circle")
                                    .font(.title)
                                 .padding(.all) }
                            
                        }.padding(.all)
                         
                        FlagReview()
                    }
                    
                    } }
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 5))
                .overlay(alignment: .bottom) {
                    if isProgressCard {
                        ProgressInfoCard(renovationProject: renovationProject)
                            .transition(.scale.combined(with: .opacity))
                            // Different way of using tranistion with different combination
//                          .transition(.asymmetric(insertion: .opacity, removal:     .scale.combined(with: .opacity)))
                    } }
           
        }
    }
}


//MARK: Without using ZStack
//struct ProgressInfoCard: View {
//    var body: some View {
//        VStack(alignment: .center) {
//            Label {
//                Text("60% Completed")
//            } icon: {
//
//                ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
//            }.padding()
//
//
//            Text("Due on Sunday, Augest 1, 2021")
//                .font(.headline)
//
//        }
//        .background(Color.white)
//        .padding()
//
//    }
//}

//MARK: Using ZStack
struct ProgressInfoCard: View {
    var renovationProject: RenovationProject
   
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                SnowflakeProg(value: renovationProject.percentComplete)
                    .padding(.top)
                Text("Due on \(renovationProject.formatedDueDate)")
//                    .font(.headline)
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()
            
        }
    }
}

//MARK: Flag review
struct FlagReview: View {
    @State var isFlagReview: Bool = false
    var body: some View {
        ZStack {
            Button {
                isFlagReview.toggle()
            } label: {
                Text(Image(systemName: "flag.circle"))
                    .font(.title)
                    .foregroundColor(isFlagReview ? .white : .accentColor)
            }.background(isFlagReview ? .red : .white)
                .clipShape(Circle())
            // .shadow(radius: 5)
          
            Circle()
                .stroke(style: StrokeStyle(lineWidth: isFlagReview ? 5 : 0))
                .frame(width: 33, height: 33, alignment: .center)
                .foregroundColor(.white)
                .scaleEffect(isFlagReview ? 1 : 0)
                .opacity(isFlagReview ? 0.5 : 0)
                .animation(.easeInOut(duration: 0.9), value: isFlagReview)
                    
            Circle()
                .stroke(style: StrokeStyle(lineWidth: isFlagReview ? 0 : 10, lineCap: .butt,  dash: [3,8]))
                .foregroundColor(.white)
                .frame(width: 44, height: 44, alignment: .center)
                .scaleEffect(isFlagReview ? 1.2 : 0)
                .rotationEffect(.degrees(isFlagReview ? 120 : 0))
                .opacity(isFlagReview ? 0.8 : 0)
                .animation(Animation.easeInOut(duration: 0.9).speed(isFlagReview ? 1.5 : 1) , value: isFlagReview)
                
            
            
        }
        

    }
}

//MARK: Status section

struct WorkQuality: View {
    var renovationProject: RenovationProject
    var body: some View {
        VStack {
            
            HStack {
                Text("Work Quality: ")
                Text(renovationProject.workQuality.rawValue)
            }
           
            HStack {
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star")
                Spacer()
                NavigationLink {
                    InspectionLogView(logEntry: InspectionLogEntry.testLogEntry)
                } label: {
                    Label("Show LogEntry", systemImage: "arrowshape.turn.up.forward.circle")
                }.foregroundColor(.blue)
            }.foregroundColor(.yellow)
            
        }
    }
}

//MARK: Punch list  section

struct PunchList: View {
    @Binding var renovationProject: RenovationProject
    @State var punchListeState = false
    @State var punchListItem: PunchListItem
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Punch List")
                .foregroundColor(.blue)
                .font(.headline)
            ForEach(renovationProject.punchList, id: \.task) { punchList in
               
                Label { Text(punchList.task) }
                icon: { punchList.statusImage }
                   
                    .onTapGesture(count: 2) {
                        punchListItem = punchList
                        punchListItem.status = .notStarted
                        
                        let index = renovationProject.punchList.firstIndex(where: { $0.task == punchListItem.task })
                        renovationProject.punchList[index!] = punchListItem  }
                    .onTapGesture {
                        punchListItem = punchList
                        punchListItem.status = .complete
                        
                        let index = renovationProject.punchList.firstIndex(where: { $0.task == punchListItem.task })
                        renovationProject.punchList[index!] = punchListItem  }
                    .gesture(LongPressGesture().onEnded({ _ in
                        punchListeState = true
                        punchListItem = punchList
                        
                    }))
                
            } .confirmationDialog("select progress", isPresented: $punchListeState, titleVisibility: .visible) {
            
                Text(punchListItem.task)
                    Button("Completed", action: {
//                        punchListItem = punchList
//                        punchListItem.status = .complete
//                        let index = renovationProject.punchList.firstIndex(where: { $0.task == punchListItem.task })
//                        renovationProject.punchList[index!] = punchListItem
                      
                    })
                    Button("In progress", action: {
//                        punchListItem = punchList
//                        punchListItem.status = .inProgress
//                        let index = renovationProject.punchList.firstIndex(where: { $0.task == punchListItem.task })
//                        renovationProject.punchList[index!] = punchListItem
                    })
                    Button("Not Started", action: {
//                        punchListItem = punchList
//                        punchListItem.status = .notStarted
//                        let index = renovationProject.punchList.firstIndex(where: { $0.task == punchListItem.task })
//                        renovationProject.punchList[index!] = punchListItem
                    })
                    
                }
//                ActionSheet(title: Text("Task progress"), message: Text("Select progress"), buttons: [.default(Text("complete"), action: {
//
//                })]                                                     )
            

        }
    }
}

extension PunchListItem
{
    var statusImage: Image {
        switch self.status {
        case .complete : return Image(systemName: "checkmark.circle")
        case .inProgress : return Image(systemName: "asterisk.circle")
        case .notStarted : return Image(systemName: "circle")
       
        }
    }
}
//MARK: Budget section

struct Budget: View {
    var renovationProject: RenovationProject
    var body: some View {
        VStack(alignment: .leading )  {
            Text("Budget")
                .foregroundColor(.blue)
            Label {
                Text("On Budget")
            } icon: {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
            
            HStack {
                Text("Amount Allocated:")
                Spacer()
                Text(String(format: "%.2f", renovationProject.budgetAmountAllocated))
                
            }
            HStack {
                Text("Spent to-date:")
                Spacer()
                Text(String(format: "%.2f", renovationProject.budgetSpentToDate))
            }
            HStack {
                Text("Amount remaining:")
                Spacer()
                Text(String(format: "%.2f", renovationProject.budgetAmountAllocated - renovationProject.budgetSpentToDate))
            }
            
        }
    }
}




struct Previews_DetailView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
