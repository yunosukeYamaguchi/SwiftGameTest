import Foundation

// キャラクターモデル
struct CharacterModel {
    // 成長段階
    enum GrowthState: Int {
        // 幼少期
        case childhood
        // 成長期
        case growthPeriod
        // 成熟期
        case maturity
    }

    // 現在の成長段階
    var currentGrowthState: GrowthState
    // 現在の体力値
    var currentHitPoint: Int
    // 最大の体力値
    var maxHitPoint: Int
    // 現在の生活環境
    var livingEnvironment: Int
    // 現在の好感度
    var favorabilityRating: Int
    // 最後に餌をあげた日時
    var lastFeedDate: Date?
    // 餌をあげた回数
    var last12HourFeedCount: Int
    // 死亡推定日
    var dateOfDeath: Date
    // 成長係数
    var growthFactor: Int {
        favorabilityRating / 10
    }

    // すでに死んでいるか
    var isDead: Bool {
        let timeInterval = Date().timeIntervalSince(dateOfDeath)
        // 0より大きい値の場合は、推定日よりも後なので死亡判定とする
        return (0 <= timeInterval)
    }
    
    init() {
        self.currentGrowthState = .childhood
        self.currentHitPoint = 10
        self.maxHitPoint = 10
        self.livingEnvironment = 10
        self.favorabilityRating = 10
        self.lastFeedDate = nil
        self.last12HourFeedCount = 0
        let random = Int.random(in: 14..<28)
        self.dateOfDeath = Calendar.current.date(byAdding: .day, value: random, to: Date())!
    }
    
    init(object: CharacterDataObject) {
        self.currentGrowthState = .init(rawValue: object.currentGrowthState) ?? .maturity
        self.currentHitPoint = object.currentHitPoint
        self.maxHitPoint = object.maxHitPoint
        self.livingEnvironment = object.livingEnvironment
        self.favorabilityRating = object.favorabilityRating
        self.lastFeedDate = object.lastFeedDate
        self.last12HourFeedCount = object.last12HourFeedCount
        self.dateOfDeath = object.dateOfDeath
    }
    
    // 餌をあげる
    mutating func feeding() {
        var isPassed: Bool = true
        // 最後の餌やり時間から12時間以上経過しているか判別する
        if let lastFeedDate = lastFeedDate {
            // 最後の餌やり時間が記録されている場合は、経過時間を算出
            let timeInterval = Date().timeIntervalSince(lastFeedDate)
            let time = Int(timeInterval)
            let hour = time / 3600 % 24
            // 12時間経過していない場合は、falseになる
            isPassed = (12 < hour)
        }

        // 回復値を生成する
        let recoveryValue: Int
        if isPassed {
            self.last12HourFeedCount += 1
            // 繰数回の回復は、1しか回復させない
            recoveryValue = 1
        } else {
            // 12時間経過している場合は、0に戻す
            self.last12HourFeedCount = 0
            // 12時間ぶりの回復の場合はランダムで回復値を変化させる
            recoveryValue = Int.random(in: 1...10)
        }

        // 餌をあげた日時を更新する
        lastFeedDate = Date()
        // 餌をあげたので、体力を回復させる
        // min関数を用いて、上限の体力値より高い体力を設定しないようにする
        currentHitPoint = min(maxHitPoint, (currentHitPoint + recoveryValue))
    }

    // トイレ掃除
    mutating func toiletCleaning() {
        // トイレの場合は、生活環境値を最大にする
        livingEnvironment = 10
    }

    // 好感度アップ
    /// - Parameter value: 遊ぶ頻度によってもたらされる好感度の値
    mutating func favorabilityUp(value: Int) {
        favorabilityRating = min(10, favorabilityRating + value)
    }

}

// TODO: トイレに関連する要素を追加
// 例: var toiletUsageCount: Int
