FROM mcr.microsoft.com/playwright/python:v1.48.0-jammy

WORKDIR /app

COPY requirements.txt .

# Install Playwright Python package
RUN pip install --no-cache-dir -r requirements.txt

# Install ONLY WebKit browser (lightweight, optimal for Railway's limited RAM)
# This saves memory compared to installing all browsers
RUN playwright install webkit --with-deps

# Verify WebKit installation
RUN python -c "from playwright.sync_api import sync_playwright; print('✅ Playwright v1.48 with WebKit ready')"

COPY . .

# Use pre-installed browsers
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

CMD ["python", "k12_bot.py"]
