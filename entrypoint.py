from typing import TYPE_CHECKING

from app import create_demo, concurrency_limit

if TYPE_CHECKING:
    import gradio as gr

if __name__ == "__main__":
    demo: gr.TabbedInterface = create_demo()
    demo.queue(
        api_open=True,
        max_size=concurrency_limit,
        default_concurrency_limit=concurrency_limit,
    )
    demo.launch(
        max_threads=concurrency_limit,
    )
