# TableViewEnums
Implement simple UITableView using Enums

I have been playing around with an approach to use the new <a href="https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html" target="_blank">Swift enum</a> to build simple UITableViews.
The idea is to wrap up all boilerplate code for registering reuseIdentifiers, dequeueing cells and adding new types of cells, in an enum that is easy to understand and maintain.

We start off by defining a Cell protocol that describes the behavior.

<pre class="lang:default decode:true " title="protocol Cell" >
protocol Cell {
    var reuseIdentifier: String { get }
    var type: UITableViewCell.Type { get }
}
</pre> 

And by declaring a conforming TableViewCell enum. 
 
<pre class="lang:default decode:true " title="enum TableViewCell: Cell" >
enum TableViewCell: Cell {
    case switchButton, subtitleLabel

    var reuseIdentifier: String {
        switch self {
        case .switchButton: return "switchButton"
        case .subtitleLabel: return "subtitleLabel"
        }
    }

    var type: UITableViewCell.Type {
        switch self {
        case .switchButton: return SwitchButtonTableViewCell.self
        case .subtitleLabel: return SubtitleLabelTableViewCell.self
        }
    }
}
</pre> 

With this setup, registering cells with the tableView looks something like this.
 
<pre class="lang:default decode:true " title="class ViewController: UIViewController" >
func setupTableView() {
    let cells = [TableViewCell.switchButton, TableViewCell.subtitleLabel]
    for cell in cells {
        tableView.register(cell.type, forCellReuseIdentifier: cell.reuseIdentifier)
    }
}
</pre> 

And this is dequeueing new cells.
<pre class="lang:default decode:true " title="extension ViewController: UITableViewDataSource" >
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cells[indexPath.row].reuseIdentifier,
                                             for: indexPath)
    return cell
}
</pre> 

Have ideas to improve this? Please let me know by [creating an issue](https://github.com/sanketfirodiya/TableViewEnums/issues/new)
