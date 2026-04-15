import Foundation

var lines: [String] = []
while let line = readLine() {
    lines.append(line)
}

let sorted = lines.sorted(by: { $0.count == $1.count ? $0 < $1 : $0.count > $1.count })

print(sorted.joined(separator: "\n"))