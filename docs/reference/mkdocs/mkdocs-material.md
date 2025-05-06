# mkdocs-material

## markdown 扩展效果

### 警告

- <https://squidfunk.github.io/mkdocs-material/reference/admonitions/#supported-types>

!!! note

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

!!! example

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod

!!! success

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod

!!! tip

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod

!!! question

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod

!!! warning

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod

!!! danger

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod

!!! bug

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod

> 可折叠警告

??? note

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla et euismod
    nulla. Curabitur feugiat, tortor non consequat finibus, justo purus auctor
    massa, nec semper lorem quam in massa.

### 注释+警告

- <https://squidfunk.github.io/mkdocs-material/reference/annotations/>

> 示例:

!!! note annotate "Phasellus posuere in sem ut cursus (1)"

    Lorem ipsum dolor sit amet, (2) consectetur adipiscing elit. Nulla et
    euismod nulla. Curabitur feugiat, tortor non consequat finibus, justo
    purus auctor massa, nec semper lorem quam in massa.

1. :man_raising_hand: I'm an annotation!
2. :woman_raising_hand: I'm an annotation as well!

### 表情符号

- <https://squidfunk.github.io/mkdocs-material/reference/icons-emojis/#with-colors-mkdocsyml>

:smile:

> 注意: 使用了自定义样式!!!

:fontawesome-brands-youtube:{ .youtube }

:octicons-heart-fill-24:{ .heart }

### 网格

- <https://squidfunk.github.io/mkdocs-material/reference/grids/#using-generic-grids-unordered-list>

<div class="grid cards" markdown>

- :fontawesome-brands-html5: __HTML__ for content and structure
- :fontawesome-brands-js: __JavaScript__ for interactivity
- :fontawesome-brands-css3: __CSS__ for text running out of boxes
- :fontawesome-brands-internet-explorer: __Internet Explorer__ ... huh?

</div>

- 示例2

<div class="grid" markdown>

=== "Unordered list"

    * Sed sagittis eleifend rutrum
    * Donec vitae suscipit est
    * Nulla tempor lobortis orci

=== "Ordered list"

    1. Sed sagittis eleifend rutrum
    2. Donec vitae suscipit est
    3. Nulla tempor lobortis orci

``` title="Content tabs"
=== "Unordered list"

    * Sed sagittis eleifend rutrum
    * Donec vitae suscipit est
    * Nulla tempor lobortis orci

=== "Ordered list"

    1. Sed sagittis eleifend rutrum
    2. Donec vitae suscipit est
    3. Nulla tempor lobortis orci
```

</div>

### 格式化

- <https://squidfunk.github.io/mkdocs-material/reference/formatting/>

> 示例:

- ==This was marked (highlight)==
- ^^This was inserted (underline)^^
- ~~This was deleted (strikethrough)~~

> 键盘按键:

++ctrl+alt+del++

### 选项卡

- <https://squidfunk.github.io/mkdocs-material/reference/content-tabs/#usage>

=== "C"

    ``` c
    #include <stdio.h>

    int main(void) {
      printf("Hello world!\n");
      return 0;
    }
    ```

=== "C++"

    ``` c++
    #include <iostream>

    int main(void) {
      std::cout << "Hello world!" << std::endl;
      return 0;
    }
    ```

### 带有警告

!!! example

    === "Unordered List"

        ``` markdown
        * Sed sagittis eleifend rutrum
        * Donec vitae suscipit est
        * Nulla tempor lobortis orci
        ```

    === "Ordered List"

        ``` markdown
        1. Sed sagittis eleifend rutrum
        2. Donec vitae suscipit est
        3. Nulla tempor lobortis orci
        ```

### 图表效果

- <https://squidfunk.github.io/mkdocs-material/reference/diagrams/>

``` mermaid
graph LR
  A[Start] --> B{Error?};
  B -->|Yes| C[Hmm...];
  C --> D[Debug];
  D --> B;
  B ---->|No| E[Yay!];
```
