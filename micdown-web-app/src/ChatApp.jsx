import React, { useState } from "react";



export default function ChatApp({ sessionToken }) {
    return (
        <div className="min-h-screen bg-[#131316] text-white flex flex-col">
            {/* Top Navigation */}
            <header className="h-12 bg-[#1a1a1d] flex items-center px-4 shadow">
            <h1 className="text-xl font-bold text-[#4f5ce4]">MICDOWN</h1>
            </header>

            {/* Main Content */}
            <div className="flex flex-1">
            {/* Left Sidebar */}
            <aside className="w-64 bg-[#1e1e21] p-4 border-r border-[#2c2c2e]">
                <h2 className="font-semibold text-sm mb-2">Channels</h2>
                <ul className="space-y-2 text-sm">
                <li># general</li>
                <li># support</li>
                <li># off-topic</li>
                </ul>
            </aside>

            {/* Center Chat */}
            <main className="flex-1 p-4 overflow-y-auto">
                <div className="text-gray-300">Welcome to MICDOWN Chat!</div>
            </main>

            {/* Right Panel */}
            <aside className="w-64 bg-[#1e1e21] p-4 border-l border-[#2c2c2e]">
                <h2 className="font-semibold text-sm mb-2">Users</h2>
                <ul className="space-y-2 text-sm">
                <li>🟢 Gamer</li>
                <li>🟡 Guest123</li>
                <li>🔴 OfflineBot</li>
                </ul>
            </aside>
            </div>
        </div>
    );
}
