"""
Command line tool to make a result grid.
"""
import click

@click.command()
@click.argument('rows', type=click.INT)
@click.argument('columns', type=click.INT)
@click.argument('contents', nargs=-1)
@click.option('--output_file','-o', default="./out.html", help='Output output_file to generate results into.')
@click.option('--title','-t', default="comparison", help='Title for the table.')
def run(rows, columns, contents, output_file, title):
    """
    Will run the grid creation
    """
    print("Run grid")
    if len(contents) != columns*rows:
        raise RuntimeError("The number of content must match the number of rows/cols %d vs %d"%(len(contents),columns*rows))
    with open(output_file, "w+") as html_file:
        #write header
        html_file.write("""
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>"""+title+"""</title>
    <style>
    table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
    }

    td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
    }

    tr:nth-child(even) {
    background-color: #dddddd;
    }
    </style>
    <script type="module" src="https://ajax.googleapis.com/ajax/libs/model-viewer/3.0.1/model-viewer.min.js"></script>
  </head>
  <body>
  <table>
        """)#TODO style and css
        #write tab
        for row in range(rows):
            html_file.write("<tr>")
            for column in range(columns):
                content = contents[row*columns+column]
                if content.endswith((".png", ".jpg", ".gif")):
                    html_file.write("<td> <img src=\""+content+"> </td>")
                elif content.endswith((".mp4", ".mpg", ".mpeg", ".ogg")):
                    html_file.write("<td> <video autoplay muted loop> <source src=\""+content+"\" type=\"video/mp4\"></video> </td>\n")
                elif content.endswith((".obj")):
                    html_file.write("<td><model-viewer src=\""+content+"\"></model-viewer></td>\n")
                else:
                    html_file.write("<td>"+content+"</td>\n")
            html_file.write("</tr>")
        #footer
        html_file.write("""
</table>
</body>
</html>
        """)

if __name__ == '__main__':
    run()
