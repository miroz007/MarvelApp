

import Foundation
import Kingfisher

public typealias EmptyCompletion = () -> Void
public typealias CompletionObject<T> = (_ response: T) -> Void
public typealias CompletionOptionalObject<T> = (_ response: T?) -> Void
//public typealias CompletionResponse = (_ response: Result<Void, Error>) -> Void
//typealias Dependencies = HasAPI & HasWindow //& HasCoreData
typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void
