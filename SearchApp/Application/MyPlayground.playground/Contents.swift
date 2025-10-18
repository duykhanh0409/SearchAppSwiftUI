//import Foundation
//
//var greeting = "Hello, playground"
//
//private let mockData1 = [
//    "[1] iPhone 15 Pro Max - Premium flagship smartphone featuring revolutionary titanium design with aerospace-grade materials, powered by the cutting-edge A17 Pro chip with advanced neural engine for unprecedented performance and efficiency",
//    "[1] MacBook Air M3 - Ultra-thin and lightweight laptop computer with exceptional performance capabilities, featuring the next-generation M3 chip architecture that delivers incredible speed while maintaining all-day battery life for professional workflows",
//    "[1] iPad Pro 12.9 - Professional-grade tablet computer powered by the advanced M2 chip with stunning 12.9-inch Liquid Retina XDR display technology, offering unparalleled color accuracy and brightness for creative professionals and content creators",
//    "[1] Apple Watch Ultra 2 - Rugged and durable smartwatch specifically designed for extreme sports enthusiasts and outdoor adventures, featuring a robust titanium case, enhanced GPS capabilities, and comprehensive health monitoring sensors for active lifestyles",
//    "[1] AirPods Pro 2 - Premium wireless earbuds with industry-leading active noise cancellation technology, featuring adaptive transparency mode, spatial audio with dynamic head tracking, and personalized listening experience with custom-tuned drivers"
//]
//
//private let mockData2 = [
//    "[2] iPhone 15 Pro Max - Starting at $1,199 with flexible financing options available, offered in multiple storage configurations from 256GB to 1TB, with trade-in programs that can reduce the final price significantly for qualifying devices",
//    "[2] MacBook Air M3 - Starting at $1,099 representing excellent value for professional-grade performance, with educational discounts available for students and teachers, plus flexible payment plans through Apple Card monthly installments with zero interest options",
//    "[2] iPad Pro 12.9 - Starting at $1,099 with professional-grade pricing that reflects its advanced capabilities, available in various storage options and connectivity configurations, with bundle deals including Apple Pencil and Magic Keyboard accessories",
//    "[2] Apple Watch Ultra 2 - Starting at $799 with premium pricing that reflects its specialized features and rugged construction, available with various band options and AppleCare+ protection plans for additional peace of mind and coverage",
//    "[2] AirPods Pro 2 - Starting at $249 positioning them competitively in the premium audio market segment, with financing options available and frequent promotional offers during holiday seasons and special events throughout the year"
//]
//
//private let mockData3 = [
//    "[3] iPhone 15 Pro Max - Currently in stock at all retail locations and online store, ships within 1-2 business days via expedited shipping methods, with same-day delivery available in major metropolitan areas through Apple Store partnerships",
//    "[3] MacBook Air M3 - Limited stock availability due to high demand from professionals and students, currently ships in 3-5 business days with priority given to educational institutions and enterprise customers with bulk order requirements",
//    "[3] iPad Pro 12.9 - Excellent stock levels maintained across all configurations, ships same day for orders placed before 3 PM local time, with express delivery options available for urgent professional and creative project deadlines",
//    "[3] Apple Watch Ultra 2 - Currently back ordered due to production constraints and overwhelming consumer demand, estimated shipping time of 2-3 weeks with priority notifications available for immediate availability updates and order status changes",
//    "[3] AirPods Pro 2 - Widely available with excellent stock levels at all retail partners, ships same day for most orders with multiple delivery options including standard, expedited, and premium white-glove delivery services"
//]
//
//// MARK: - simulate time for network request
//private func randomNetworkRequestTime() -> TimeInterval {
//    return TimeInterval.random(in: 1.0...5.0)
//}
//
//// MARK: - Data Loading
//private func loadData() {
//    let group = DispatchGroup()
//    
//    var listOne: [String] = []
//    var listTwo: [String] = []
//    var listThree: [String] = []
//    
//    // Request 1
//    group.enter()
//    DispatchQueue.global().asyncAfter(deadline: .now() + randomNetworkRequestTime()) {
//        listOne = mockData1
//        print("✅ Data 1 loaded")
//        group.leave()
//    }
//    
//    // Request 2
//    group.enter()
//    DispatchQueue.global().asyncAfter(deadline: .now() + randomNetworkRequestTime()) {
//        listTwo = mockData2
//        print("✅ Data 2 loaded")
//        group.leave()
//    }
//    
//    // Request 3
//    group.enter()
//    DispatchQueue.global().asyncAfter(deadline: .now() + randomNetworkRequestTime()) {
//        listThree = mockData3
//        print("✅ Data 3 loaded")
//        group.leave()
//    }
//    
//    group.notify(queue: .main) {
//        let mergedList = listOne + listTwo + listThree
//        mergedList.forEach { print($0) }
//    }
//}
//
//loadData()
//




public struct Queue<T> {
        
    private var instack: [T] = []
    private var outStack: [T] = []
    
    public init() {}
    
    public mutating func enqueue(_ element: T) {
        instack.append(element)
        //O(1)
    }
    
    public mutating func dequeue() -> T? {
        if outStack.isEmpty {
            while let element = instack.popLast() {
                outStack.append(element)
            }
        }
        
        return outStack.popLast()
        //O(1)
    }
    
    public func peek() -> T? {
       if let last = outStack.last {
            return last
       } else {
           return instack.first
       }
    }
    
    public var isEmpty: Bool {
        return instack.isEmpty && outStack.isEmpty
    }
    
    public var count: Int {
        return instack.count + outStack.count
    }
}


