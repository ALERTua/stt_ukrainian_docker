from app import create_demo, concurrency_limit

if __name__ == "__main__":
    demo = create_demo()
    demo.queue(
        api_open=True,
        max_threads=concurrency_limit,
        max_size=concurrency_limit,
        default_concurrency_limit=concurrency_limit,
    )
    demo.launch(
        show_api=True,
    )
