//
//  Supabase.swift
//  TodoList
//
//  Created by 孟元森 on 2024-05-24.
//

import SwiftUI
import Supabase

let supabase = SupabaseClient(
    supabaseURL: URL(string: "https://dzlclcsukeyyklxjwkfw.supabase.co")!,
    supabaseKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR6bGNsY3N1a2V5eWtseGp3a2Z3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY0Nzk2ODksImV4cCI6MjAzMjA1NTY4OX0.AVkmZZCMeVDniSVp8le6UnmusCnCQySLJZl0vlax0l8")
